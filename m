From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC PATCH] format-patch: thread as reply to cover letter even 
	with in-reply-to
Date: Mon, 16 Feb 2009 15:22:14 -0500
Message-ID: <76718490902161222p7f1ecbf9x6f965ff94b3cfae7@mail.gmail.com>
References: <cover.1234801852.git.trast@student.ethz.ch>
	 <1234810812-30499-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZA0G-0003YO-IA
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbZBPUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbZBPUWQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:22:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:58776 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZBPUWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:22:15 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1693203rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eAtGl+p4TeHZOwvcaOUaV7L2PaM7GRupGUzy98by8RE=;
        b=dpSa3teaNxK53sihpTpfuKjfZ1f8FxOyEZAbDsw9Az9OXpw6EmS/OiP2e80SelezP6
         htEg7yG4QJKoxqlUXYg9+ob+CWE/ets7wi7T7Jqg5ba3wbWErj0aaMvUP4PRpE7k5FjJ
         nmWsHWcczWotq28LmB20mdeGLPa8HS4OnXbxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QiW/zU0neHwiUvyDEsLPxmCLFWeb12xRtxuo6FXWEJOHMdwvYSlmsHBf++hjL3UkHK
         UPRgjoUVt1vr1zL7TtaFE5IjBLfbeaZUKYESBMNAi2r5SFWU72JDsgOOPfJ1vZuWQxkS
         wXMp0CjPAob72aRP9x24y4y4YhxUCV4cei/Zw=
Received: by 10.141.153.16 with SMTP id f16mr787288rvo.272.1234815734932; Mon, 
	16 Feb 2009 12:22:14 -0800 (PST)
In-Reply-To: <1234810812-30499-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110234>

On Mon, Feb 16, 2009 at 2:00 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Currently, format-patch --thread --cover-letter --in-reply-to $parent
> makes all mails, including the cover letter, a reply to $parent.
> However, we would want the reader to consider the cover letter above
> all the patches.
>
> This changes the semantics so that only the cover letter is a reply to
> $parent, while all the patches are formatted as replies to the cover
> letter.

I think this change may be okay, but I think to go with it the
cover-letter and all the patches should have a "References:" header
with the message-id given by --in-reply-to.

RFC 2822 says:

   The "In-Reply-To:" and "References:" fields are used when creating a
   reply to a message.  They hold the message identifier of the original
   message and the message identifiers of other messages (for example,
   in the case of a reply to a message which was itself a reply).  The
   "In-Reply-To:" field may be used to identify the message (or
   messages) to which the new message is a reply, while the
   "References:" field may be used to identify a "thread" of
   conversation.

j.
