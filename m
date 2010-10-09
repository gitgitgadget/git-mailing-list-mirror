From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Sat, 9 Oct 2010 15:39:27 -0700
Message-ID: <617F82D8-DDDE-422C-B4F9-9D35B24BB420@sb.org>
References: <4C6A1C5B.4030304@workspacewhiz.com> <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost> <7v4oepaup7.fsf@alter.siamese.dyndns.org> <20100821080512.GA30141@localhost>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:39:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4i4m-0000ht-5j
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab0JIWjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:39:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60421 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab0JIWja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 18:39:30 -0400
Received: by pzk34 with SMTP id 34so655639pzk.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:39:30 -0700 (PDT)
Received: by 10.142.218.15 with SMTP id q15mr2208377wfg.405.1286663970010;
        Sat, 09 Oct 2010 15:39:30 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id q13sm5731659wfc.17.2010.10.09.15.39.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 15:39:29 -0700 (PDT)
In-Reply-To: <20100821080512.GA30141@localhost>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158635>

On Aug 21, 2010, at 1:05 AM, Clemens Buchacher wrote:

> Files that go into a tracked .gitignore are most likely generated
> files, and therefore trashable. Files that go into
> .git/info/exclude or into an untracked .gitignore (e.g. echo '*' >
> precious-simulation-results/.gitignore), are not always generated
> and may not be trashable. At least they would not likely get in the
> way of checkout or merge.

I can think of at least one common case that doesn't match this pattern - A web app that has a config file. What I've seen frequently done is the config file is named something like foo.config.template, and that's tracked, and you're encouraged to copy this to foo.config and change the values. This file may not want to be tracked because it contains sensitive information like database passwords, so the repo may stick it in the .gitignore file to ensure that this never gets added. However, this is most definitely a "precious" file. For this case, and others like it, I am strongly in favor of Junio's suggestion to add a 3rd category "precious but untracked".

-Kevin Ballard