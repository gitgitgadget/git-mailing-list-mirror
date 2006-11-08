X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Wed, 8 Nov 2006 09:41:33 +0000
Message-ID: <b0943d9e0611080141y3751039v37b0289147237e4f@mail.gmail.com>
References: <eile19$p7r$1@sea.gmane.org>
	 <20061106074532.10376.60478.stgit@localhost>
	 <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
	 <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
	 <20061108084038.GA3164@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 09:41:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VOn9nS2LNUc3s0FM8810cBXlwTf+CIXang3RenSdZnhIVZAWXViCs/7eZfVmbeZC1bkWjOYUoPl5+uZtGDj5El81C+VCGiabZM6Bsi71tzDMQNdFwjqBLsMwVxSVfFeKnnjVIOG3mHlnu9eJPT57Rme+5GYY2PzaHFG7sUAoJFg=
In-Reply-To: <20061108084038.GA3164@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31131>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhjwA-0006Ks-KI for gcvg-git@gmane.org; Wed, 08 Nov
 2006 10:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754480AbWKHJlf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 04:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbWKHJlf
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 04:41:35 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:31242 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1754480AbWKHJle
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 04:41:34 -0500
Received: by py-out-1112.google.com with SMTP id a73so1464996pye for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 01:41:34 -0800 (PST)
Received: by 10.35.69.11 with SMTP id w11mr15087237pyk.1162978893842; Wed, 08
 Nov 2006 01:41:33 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Wed, 8 Nov 2006 01:41:33 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 08/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-11-07 19:09:06 +0000, Catalin Marinas wrote:
>
> > I re-implemented parts of the mail and import commands (inspiring
> > from your patches). They now use the email Python package. The mail
> > command encodes the body to 7 or 8bit depending on non-ascii
> > characters.
>
> Even though it turned out to be possible to use 8bit always?

I just let the Python email package to the encoding and it first tries
pure ascii and switches to 8bit if this fails. This package
automatically adds the proper e-mail headers based on the encoding
type. It can also do QP or base64 encodings (if someone complains of
an old SMTP server, maybe I'll add a config option to force QP body).

> > I still have to write a test script but my simple tests showed that
> > it works. Please let me know if there is anything wrong (especially
> > with the QP-encoding of the mail headers).
>
> I won't have time to check this out today (in fact, it may have to
> wait until the weekend). But when I do check it out, I might have tim=
e
> to write that test, so please holler if you start working on that.

It would be great if you can run a test script. I've been thinking
more of an "import" test that also checks both the "export" and "mail"
commands. BTW, I'll try to add support for mbox importing which is
pretty easy with the email package.

--=20
