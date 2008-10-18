From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 14:50:51 +0200
Message-ID: <gdcm3d$f3k$1@ger.gmane.org>
References: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 14:53:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrBIx-0003Ax-3H
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYJRMvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbYJRMvG
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 08:51:06 -0400
Received: from main.gmane.org ([80.91.229.2]:40655 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbYJRMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 08:51:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KrBGn-0000yq-2M
	for git@vger.kernel.org; Sat, 18 Oct 2008 12:51:01 +0000
Received: from 94.37.30.171 ([94.37.30.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 12:51:01 +0000
Received: from giuseppe.bilotta by 94.37.30.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 12:51:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.30.171
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98544>

On Saturday 18 October 2008 14:08, Leo Razoumov wrote:

> Hi Everyone,
> I wonder what is the preferred way to submit patches from a gmail account.
> Google mail auto wraps long lines and there is no way to change this setting.
> Safe way would be to use attachments. Are they allowed on git mailing list?

I've been sending patches from gmail for a while without problems. It took me
a while to find a working configruation, but I finally managed to do it using
msmtp. I have

[sendemail]
        smtpserver = /usr/bin/msmtp

in my ~/.gitconfig

and the following ~/.msmtprc

======
# Example for a user configuration file

# Set default values for all following accounts.
defaults
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile ~/.msmtp.log

# My email service
account gmail
host smtp.gmail.com
from yourgmailusername@gmail.com
auth on
user yourgmailusername
password yourgmailpassword

# Set a default account
account default : gmail
=========

And to send patches I just use something like

git send-email --to "git@vger.kernel.org" --cc "whoever" 00*

-- 
Giuseppe "Oblomov" Bilotta
