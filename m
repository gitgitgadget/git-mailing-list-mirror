From: "Vincent B." <vb@luminar.eu.org>
Subject: Unable to clone a repo over an IPv6 link local address: port got
 trimmed to 4 chars
Date: Tue, 24 Jun 2014 14:47:26 +0200
Message-ID: <53A9735E.8080604@luminar.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 14:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzQGf-0004Ek-9S
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 14:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbaFXM4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 08:56:05 -0400
Received: from luminar.eu.org ([94.23.24.152]:33197 "EHLO luminar.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbaFXM4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 08:56:04 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2014 08:56:03 EDT
Received: from [192.168.1.105] (AMontsouris-652-1-53-131.w92-163.abo.wanadoo.fr [92.163.36.131])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by luminar.eu.org (Postfix) with ESMTPSA id 3D64E61632
	for <git@vger.kernel.org>; Tue, 24 Jun 2014 14:47:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252405>

I discovered an issue while trying to clone a git repo over an IPv6 link-local address:

[vb@nerenyi ~/code/ocaml-llnet]% LANG=C git clone "http://[fe80::226:c6ff:fe50:efa0%wlan0]:33075/repo"

Cloning into 'repo'...
fatal: unable to access 'http://[fe80::226:c6ff:fe50:efa0%wlan0]:33075/repo/': Failed to connect to fe80::226:c6ff
:fe50:efa0 port 3307: Connection refused

It tries to connect to port 3307, and not 33075, strangely.

Cheers,

Vincent Bernardoff
