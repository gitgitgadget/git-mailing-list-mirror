X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 12:44:48 +0000
Message-ID: <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	 <20061103095859.GC16721@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 12:45:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HaxHj3c4IgXkiEX+saSeYzRqcuXHipGsek0osL7eD3kgwkUXQCwykLptfFXon8yfKEWKFNJFQoi0J6FJOzJfMLbWKj2tO5uJkRtVOc5LFS7rqFKTi460hz7UJDUsMCGsj8QNXp07VPefptPi90HyCGz7nhBgTziJp/M7SSCcXOs=
In-Reply-To: <20061103095859.GC16721@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30843>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfyQL-0000nX-BP for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751552AbWKCMpX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 07:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWKCMpX
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:45:23 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:31076 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1751552AbWKCMpW
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 07:45:22 -0500
Received: by py-out-1112.google.com with SMTP id a73so310166pye for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:44:49 -0800 (PST)
Received: by 10.35.19.9 with SMTP id w9mr3253557pyi.1162557888915; Fri, 03
 Nov 2006 04:44:48 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 04:44:48 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 03/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I believe all the mails I send with mutt are QP-encoded, and they
> don't look funny, do they? (You'd see the separator just above my
> signature as "--=3D20" if that was the case; it has a trailing
> whitespace.)

This e-mail, in gmail:

Content-Type: text/plain; charset=3Diso-8859-1
Content-Transfer-Encoding: 8bit

In Gnus (via gmane, no "=3D20" displayed though Gnus can handle this
encoding correctly):

Content-Type: text/plain; charset=3Diso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

It looks like the mail server re-encodes the message.

> > However, I'd like the message body to still be 8bit and the QP
> > encoding optional (either command line option or [stgit] config
> > variable).
>
> Are you sure? Wouldn't it be better to teach StGIT to eat QP-encoded
> mails, and use 7bit encoding when the patch is all ascii? (And still
> have an option to force 8bit instead of QP if desired, of course.)

Well, I don't have any strong opinion here, as long as QP is more
widely available. My impression with Gnus was that it cannot handle
but I think there was an encoding problem.

The initial mail command implementation was inspired from sendpatchset
but we should probably now use the email Python package and let it
handle the encoding and decoding (for import).

--=20
