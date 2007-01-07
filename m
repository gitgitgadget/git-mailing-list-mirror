From: "Chris Lee" <chris133@gmail.com>
Subject: Re: [PATCH] git-svnimport: support for incremental import
Date: Sun, 7 Jan 2007 10:12:24 -0800
Message-ID: <204011cb0701071012g30cb69a5h4622d94574d10521@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <20070104213142.GE11861@sashak.voltaire.com>
	 <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com>
	 <20070107001719.GB16771@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 19:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3cVd-0000ld-WD
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 19:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbXAGSM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 13:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXAGSM1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 13:12:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:37443 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964800AbXAGSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 13:12:25 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7764058wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 10:12:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSajgsu9kgArOKPTt8J78LpdsM6eRPjTB2P6Nf+hC9u0ivK3FoENzAGo+voTgGY6Lb+4S/EYOgDLPTzvpDFWAGBCs+uFtYTN56sKw7uo9SYwK7MhA+SAArZf29yVmguDdgNzbaTWNEJuEbJDJ+ou3XJsbyIFw1hNxN4ETaDqW8I=
Received: by 10.90.84.17 with SMTP id h17mr1779572agb.1168193544059;
        Sun, 07 Jan 2007 10:12:24 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Sun, 7 Jan 2007 10:12:24 -0800 (PST)
To: "Sasha Khapyorsky" <sashak@voltaire.com>
In-Reply-To: <20070107001719.GB16771@sashak.voltaire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36180>

On 1/6/07, Sasha Khapyorsky <sashak@voltaire.com> wrote:
> This adds ability to do import "in chunks" (default 1000 revisions),
> after each chunk git repo will be repacked. The option -R is used to
> change default value of chunk size (or how often repository will
> repacked).

Actually, I just noticed an issue here with this - it appears to be
double-importing the edge revisions.

So if I started with -s 349000 and tell it to repack every 1000
revisions, it's now importing every thousandth revision twice.

Off-by-one?
