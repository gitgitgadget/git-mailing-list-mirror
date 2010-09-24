From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the object store
Date: Sat, 25 Sep 2010 01:44:15 +0200
Message-ID: <AANLkTinsotbGpg1LAXA+UchBHQrBK12tkX+o4tOFWUOF@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <1284596048.3298.3.camel@wilber> <20100924194313.GA8114@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sam Vilain <sam@vilain.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 01:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHwY-00080I-L9
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 01:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab0IXXoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 19:44:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48552 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab0IXXog (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 19:44:36 -0400
Received: by ywh1 with SMTP id 1so1138811ywh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9qQGI6avdjbfiPLBNaqLAwMSWoZsOm2mqj9Qerg1+wc=;
        b=YyAApsze1+yP003TO7MyXrtnaq+mPZyX+L7nvycXfiT3x7Co6tQMoh2da0RBUjXQjm
         eI+HbpZGuZ+/ajvjQvJ7agWnGn9qvynJ5crQrNKj/vZ613w1EYK4TjthdQyyoI6eQ5WE
         FUjbJ03GDKNz+Qrhy3rluK99gCtxUJOWGX+q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=r5NOH79HcGtoHQ2VL2aoup6YUTTvdMOkucFxyXZ4bl4ml8YbkxB4XQsdzT+feqsJSz
         176IijCevAVaoeMWzJN0KWu0EzDTQ4FDAv153B/S4vsGdgj1ehts8AZgIq6Q9+iAbs6x
         f62XRNBeiGkNhPYOW4LDUBaa7H3aOP1pVLt1w=
Received: by 10.150.11.20 with SMTP id 20mr5419483ybk.407.1285371875646; Fri,
 24 Sep 2010 16:44:35 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 24 Sep 2010 16:44:15 -0700 (PDT)
In-Reply-To: <20100924194313.GA8114@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157103>

Heya,

On Fri, Sep 24, 2010 at 21:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Yes, I guess "feature report-fd=3" is a protocol layering violation.
> Unfortunately import-marks and export-marks have already set a
> precedent.

I don't agree, they (can) use a relative path name, allow the stream
to be re-used at a different location.

> Well-behaved streams could use that and rely on the fd to be set on
> the command line, while poorly-behaved streams could still use
> "feature report-fd=whatever" to get the effect of --report-fd=whatever
> and avoid breaking UI consistency.

Additionally you could have the commandline override whatever the
stream sets, so that the stream can be re-used as long as the user
specifies the appropriate commandline arguments?

-- 
Cheers,

Sverre Rabbelier
