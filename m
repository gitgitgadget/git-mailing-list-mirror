From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] t0081 (line-buffer): add buffering tests
Date: Sun, 2 Jan 2011 19:34:57 -0600
Message-ID: <20110103013457.GB30791@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103010716.GE30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 02:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZZKO-00013Y-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 02:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab1ACBfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 20:35:09 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51242 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab1ACBfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 20:35:08 -0500
Received: by gyb11 with SMTP id 11so5043575gyb.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 17:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EmajWEkFmyZWEPbe5RbHuc028lUaElzEMryKSid0wE8=;
        b=LgPY6UCP0yTAS9nm6yEakV0E+llxKQS+aXPWpQJjFK+zr/ksxnIAd0arwwFBN8chMz
         SQMM6Opn0L9DHUbwgdqcVwxyldcz6LP1eTr90ndi+1vgvtVzpWAta1/cGJv/cLb1d2By
         vKhgYCiD9oPnbjkREbTDkZzId1Q/mteXyiGfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QWj06dPkHiYVaS1A6zksMXGF8lzNCYpC0Jn+2IjsKKyHRc35ZrR7R3d67iKz+T6RkQ
         OW/JIdU03iXyBJV3p722Ra9CpJeDT7O9dUo46HD7U1kNgB2rypjJLVEdsT7rQWxgmX6u
         zLF2kGtMtPKRwDO9xvOgWBUkDvrfEj2zSfZdQ=
Received: by 10.100.37.7 with SMTP id k7mr2376979ank.76.1294018508031;
        Sun, 02 Jan 2011 17:35:08 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id d15sm27409796ana.35.2011.01.02.17.35.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 17:35:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103010716.GE30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164436>

Jonathan Nieder wrote:

> First check that fread can handle a 0-length read from an empty fifo.
> The writing end of the fifo is opened in advance in a subshell since
> even 0-length reads are allowed to block when the writing end of a
> pipe is not open.

Erm, what I mean here is that open(O_RDONLY) will block until the
writing end has been opened.
