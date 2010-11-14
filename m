From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 15:54:42 -0600
Message-ID: <20101114215442.GC16413@burratino>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkXt-00069z-FP
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab0KNVzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:55:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43586 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088Ab0KNVzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:55:17 -0500
Received: by gyh4 with SMTP id 4so2687263gyh.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B9HXOxVHXF8VPOm75fUpBVNAMtjwd9itmnEnzqcixaw=;
        b=CxRZ3wD9h+RzreSCcEeineTlBYZyE1RONMYiBvsrsKlXsU/7FZjOI5DK5St46sUek+
         e/bSBiVzEQDiuMJUno4jcOmqAycA/Gfkn7yanmAln3OnouEPAUTUKw26UF5T80unr8E3
         7237Rh3yraOs/OtD1fWDMEK0UfWGZ43jtepGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R66yLrzRkG4f5QWzKR3+rjdrNZK2GLcwCPZTUZgzHykSE3rnCnBMgp3WXOEb/oaR1m
         4luqP5UPlj+KT+dlS8+23UXJwkejntCAwR6hCtggOKxav9XaUgGRwMEeXC0WrsRo3f/n
         RtPXoG+TgaAnk54JD5G/hyKSW7K6k4DTmKEZI=
Received: by 10.150.216.1 with SMTP id o1mr5816463ybg.384.1289771716262;
        Sun, 14 Nov 2010 13:55:16 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm2427640ybk.15.2010.11.14.13.55.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:55:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161453>

Bert Wesarg wrote:

> There is one feature that the upstream git gui lacks[1]: This grep gui can start
> the git editor on every line by clicking with button 2 in the result area. The
> git editor will than be started with the environment variable FILENAME and
> LINENUMBER set but no argument given. This makes it possible to distinguish
> between normal, blocking edit operation (like git commit) from this
> open-and-forget type of operation.

This sounds like an excellent sort of thing to add to git grep -O, too
(which currently has very limited support for editors' line number
features).  But what will it do with typical non-git-specific setups
like

	VISUAL=vim

or

	EDITOR="gvim --nofork"

?

Do existing editors support LINENUMBER in the environment?
