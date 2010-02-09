From: =?ISO-8859-1?Q?G=E1bor_Farkas?= <gabor@nekomancer.net>
Subject: git + davfs2, is it safe?
Date: Tue, 9 Feb 2010 17:39:32 +0100
Message-ID: <2c173a351002090839v45d01d5dt17e4b4af37e84615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 17:39:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Net7l-00054x-85
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 17:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab0BIQjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 11:39:36 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:38546 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0BIQjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 11:39:35 -0500
Received: by ewy28 with SMTP id 28so4014108ewy.28
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 08:39:34 -0800 (PST)
Received: by 10.216.86.204 with SMTP id w54mr2660674wee.54.1265733572898; Tue, 
	09 Feb 2010 08:39:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139412>

hi,

for various reasons our git repositories are hosted using https (webdav),
which is http-auth and client-certificate authenticated.

(linux on both the server and the client)

it's possible to somehow persuade git to push/fetch from such repositories,
but it's very annoying because either you have to enter your
username+password+cert_password
on every fetch and twice on every push, or you have to write them down
in $HOME/.netrc .

an alternative that seems to work is to mount the webdav directory using davfs2,
and then use it with git as a normal mounted filesystem.

it seems to work ok (a little slow, but usable), but i'm a little
worried about possible corner-cases.
for example, will it be ok if two people are trying to push into it at
the same time, etc?

so generally, is it safe/recommended to use git in such a deployment, or not?

p.s: or, does anyone know about a better way to handle the
username/password/cert_password
when accessing the webdav-repo directly (without davfs2)?

thanks,
gabor
