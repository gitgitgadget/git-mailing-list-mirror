From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 1/2] git_default_config() rewritten using the config-set API
Date: Wed, 13 Aug 2014 18:00:47 +0200
Message-ID: <vpq1tsks7kg.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com>
	<vpq4mxgtu07.fsf@anie.imag.fr> <53EB6914.2030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:00:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHayx-0005ur-6u
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 18:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbaHMQAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 12:00:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35602 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaHMQAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 12:00:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DG0jq9032222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 18:00:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DG0lj6025844;
	Wed, 13 Aug 2014 18:00:47 +0200
In-Reply-To: <53EB6914.2030807@gmail.com> (Tanay Abhra's message of "Wed, 13
	Aug 2014 19:03:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Aug 2014 18:00:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DG0jq9032222
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408550447.93951@Bbv5wrQ1obx3PCDYSqCnEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255213>

Tanay Abhra <tanayabh@gmail.com> writes:

> git_default_config() now uses config-set API functions to query for
> values.

I believe you missed a few spots:

$ git grep -n 'git_default_config[^(]'
Documentation/user-manual.txt:4287:        git_config(git_default_config);
archive.c:416:  git_config(git_default_config, NULL);
builtin/config.c:577:           git_config(git_default_config, NULL);
color.h:73: * if you are just going to change to git_default_config, too.
fetch-pack.c:880:       git_config(git_default_config, NULL);
http.c:393:     config.cascade_fn = git_default_config;
rerere.c:580:   git_config(git_default_config, NULL);
rerere.c:710:   git_config(git_default_config, NULL);

The following ones should probably be rewritten too:

archive.c:416:  git_config(git_default_config, NULL);
builtin/config.c:577:           git_config(git_default_config, NULL);
fetch-pack.c:880:       git_config(git_default_config, NULL);
rerere.c:580:   git_config(git_default_config, NULL);
rerere.c:710:   git_config(git_default_config, NULL);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
