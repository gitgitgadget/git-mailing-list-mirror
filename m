From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: git am and CRLF files
Date: Mon, 30 Nov 2009 13:06:04 +0100
Message-ID: <9accb4400911300406l592306c8t889c28ba7b48674b@mail.gmail.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com>
	 <4B01004A.8060600@atlas-elektronik.com>
	 <20091116195036.6117@nanako3.lavabit.com>
	 <40aa078e0911160343k41393197s56d26576bcbfbe90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 30 13:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF51B-0004iQ-TQ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 13:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbZK3MGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 07:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZK3MGA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 07:06:00 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53992 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbZK3MF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 07:05:59 -0500
Received: by bwz27 with SMTP id 27so2419554bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 04:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0BBrdM3axVk47cEw3Dj/ulR4EV+7c+vzaM3NN+SPryI=;
        b=ivAJ7AOfqIwhZ0UzZL0IcOtqcvrTEL8/Gmq0YWhwZockK2rVA/Pq56sTI+JABG77eE
         mCmZ4f0qk1bWSuIt3DARPYWQc8V50HHyrJ+8N09A1rKZAGTciEI6AIo0JsZ2c8D8plbB
         4E4YiyP6yYEUnhPlA5jh6YoxTKZWGkJ4PiSc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rLEwPCkLK/pU7Xw40SbrQHcGeszIb+hcJi9c3p6m6wmlV6TdvN7qE8PWv8fDPoCexp
         LrRatSP9hUYQSg6m4K04srV8sQQj49x+rI9wbJuV1RzOFt8MQ2x3Pp5oUnmNBgLUvNQc
         TVxzCPBszyoNGc3jlzLweMH/sL0mVWYloq8k8=
Received: by 10.204.24.71 with SMTP id u7mr4519421bkb.35.1259582764619; Mon, 
	30 Nov 2009 04:06:04 -0800 (PST)
In-Reply-To: <40aa078e0911160343k41393197s56d26576bcbfbe90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134092>

On Mon, Nov 16, 2009 at 12:43 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> According to RFC 5322, email messages use CRLF as the
> newline-sequence. In order to be able to distinguish between CRLF and
> LF in an e-mail patch, the message needs to be use some
> transfer-encoding that preserves newline style (like base64).
>
> Perhaps this would be better fixed by having format-patch (or prehaps
> the MUA ?) base64-encode the message body if the file contains
> non-LF-newlines, and normalizing CRLF to LF before transport-decoding?
> Or does some MUAs transport-decode before storing the message to disk?
>
> I realize this might make it a bit tricky to review patches that
> contains CRLF-newlines before mailing them out, but perhaps inspecting
> the format-patch output is the wrong place to do this?


why don't adding that information in the mail header?
or may be made format-patch create a "comment line" with that information?

if that line is missing it could keep the default behavior (what it
did until now)
