From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commiting automatically
Date: Sun, 10 Oct 2010 23:11:35 +0200
Message-ID: <vpqzkulah2w.fsf@bauges.imag.fr>
References: <loom.20100924T224155-693@post.gmane.org>
	<AANLkTimpyTVe+OhYRhsV3H8TGahgsASOPAZRqwR=V6od@mail.gmail.com>
	<loom.20101010T212207-709@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53BT-0007aH-Ax
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab0JJVLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 17:11:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38980 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab0JJVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:11:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9AKviNR014112
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Oct 2010 22:57:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P53BA-0000es-84; Sun, 10 Oct 2010 23:11:36 +0200
In-Reply-To: <loom.20101010T212207-709@post.gmane.org> (Maaartin's message of "Sun\, 10 Oct 2010 19\:23\:56 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 10 Oct 2010 22:57:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9AKviNR014112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1287349066.93581@xBYw+S7h5CVrXdWQhdlLWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158707>

Maaartin <grajcar1@seznam.cz> writes:

> # the first parent should be autocom
> parent1="-p $(git show-ref -s refs/heads/autocom)"
> # needed for the very first use
> test -f .git/refs/heads/autocom || parent1=""

Don't use the content of .git/refs/ directly. Git can pack them, and
you can have a branch autocom packed in .git/info/refs without having it in
.git/refs/*

perhaps

parent1=$(git show-ref -s refs/heads/autocom)
if [ "$parent1" != "" ]; then
	parent1="-p $parent1"
fi

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
