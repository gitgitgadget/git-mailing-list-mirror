From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-remote-mediawiki: do not remove installed files in
 "clean" target
Date: Mon, 11 Nov 2013 12:45:04 -0800
Message-ID: <20131111204504.GM10302@google.com>
References: <20131109022239.GI10302@google.com>
 <vpqli0xstcw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyME-00065p-3K
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab3KKUpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:45:10 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:65057 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3KKUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:45:08 -0500
Received: by mail-pd0-f178.google.com with SMTP id p10so1126391pdj.23
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TPseVs7Jz0Gpx4erpsmWZUbIcobCqAh2E7sylsUHwro=;
        b=Y+XY746FTeTdsoxS+e30E8EO04cPYFrOhv8UCJnf+gSHAaRfGAP2OQa6tPOmzIfMDB
         O75pznBQd9DqENQM8FbZyGIVM/JeIt6+Hx+EQO6SiCCz0QaS8hxon8u9eMQxgrlPRpCp
         fLA8nBwzKfGHKTRyzFaLZiRR9z71u4CtxtHL39JOBt43zHToPQFQPdutIUjXa3PRQ3W0
         5+JyPZd8rktzARwwBRbKdWJiatk4cZksii9404cQLLb2Vs2rDWQA/jrxewfvuiZg7PSF
         M+jGJf73loVTkmFY4Co/FT34PiQey5+IK+SCkQ8anYtpqnMulymK2F/FcqAKPiw2+gNg
         p3MA==
X-Received: by 10.68.166.67 with SMTP id ze3mr3916250pbb.173.1384202707974;
        Mon, 11 Nov 2013 12:45:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cw2sm15167564pbb.25.2013.11.11.12.45.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:45:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpqli0xstcw.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237646>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Running "make clean" after a successful "make install" should not
>> result in a broken mediawiki remote helper.
>
> Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks for looking it over.  Here are a few more makefile tweaks on
top of that one.

Jonathan Nieder (3):
  git-remote-mediawiki: honor DESTDIR in "make install"
  git-remote-mediawiki build: make 'install' command configurable
  git-remote-mediawiki build: handle DESTDIR/INSTLIBDIR with whitespace

 contrib/mw-to-git/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
