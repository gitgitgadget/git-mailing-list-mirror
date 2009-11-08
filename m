From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 4/4] Re-implement 'git remote update' using 'git fetch'
Date: Sun, 08 Nov 2009 22:10:44 +0100
Message-ID: <hd7c4k$aul$3@ger.gmane.org>
References: <4AF6E865.1030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 22:15:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7F6R-00018q-JQ
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZKHVPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbZKHVO7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:14:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:37169 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbZKHVO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:14:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7F6F-00014Z-Uz
	for git@vger.kernel.org; Sun, 08 Nov 2009 22:15:03 +0100
Received: from 85.93.118.17 ([85.93.118.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:15:03 +0100
Received: from bonzini by 85.93.118.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85.93.118.17
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <4AF6E865.1030900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132417>

On 11/08/2009 04:48 PM, Bj=C3=B6rn Gustavsson wrote:
> In order to not duplicate functionality, re-implement 'git remote
> update' in terms of 'git fetch'.
>
> There is one incompatibility: the skipDefaultUpdate configuration
> variable will only be honored if remotes.default is not set (i.e.
> when 'git remote update' will invoke 'git fetch --all', not when
> it will invoke 'git fetch default').

Rather than introducing this incompatibility, I'd rather see 'git remot=
e=20
update' deprecated (so that the code will one day go away for good) and=
,=20
for now, leave duplicated functionality for the incompatible case.

It would be great if the deprecation message for "git remote update"=20
spewed out commands to convert the old configuration to what is needed=20
for "git fetch --all" to work in the same way.

Paolo
