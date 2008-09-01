From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 23:44:09 +0200
Message-ID: <36ca99e90809011444v3fca09c4o4d9dcf1a7249a00a@mail.gmail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080901131523.GA6739@neumann>
	 <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
	 <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
	 <20080901191051.GD7482@spearce.org>
	 <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com>
	 <7v7i9vv9n2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHD3-0004xM-8c
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYIAVoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYIAVoL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:44:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:50181 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYIAVoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:44:10 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1684007wri.5
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LLjyxai0NxuFzS/6VxmBLdrU8XlbsaRNrKfizzytgUc=;
        b=RpWa8y2BXxhSRq/CeIaE6mX0k1D4E4etDCYoaJrJrOwW2CokYWjlfROQymHi7lNnkV
         n0A7eT2VT8Qw+7al0blRCtovK1FzX28kt4Uq1Y155e/dmKCtg2nGbci7OuHlu1WfA5ND
         DLCozciI6A+5Zgyh3AtllCiH1t/RFpY59ip3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OUusrZ7JMxv17ex2EZsvr+DjZdVk94tjx2CgawhYmtqQawVJppwCUfX4ydAcU5G9D9
         9e/37vMKDZ2+RaXlmIQPGHkS8WKChzc2BqGtdnWq29O4+56reKP9eNTUK3wAkxP5iOoD
         JIcmtLCHTz6W3JgccOEE7U6NA66Khv6yj4kow=
Received: by 10.90.70.6 with SMTP id s6mr8454538aga.17.1220305449418;
        Mon, 01 Sep 2008 14:44:09 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 14:44:09 -0700 (PDT)
In-Reply-To: <7v7i9vv9n2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94614>

On Mon, Sep 1, 2008 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
>
>> On Mon, Sep 1, 2008 at 21:10, Shawn O. Pearce <spearce@spearce.org> wrote:
>> ...
>>> You can still get ambiguous names.  Avoiding them requires going
>>> through all refs and building their short forms, then using the
>>> full ref name for any ref which had more than one name shorten to
>>> the same string.  Ugly, but implementable, and probably something
>>> that should be considered.
>>
>> What about: try the list backwards until the first match, than try the
>> matched part (this what %.*s matched) with the forward list, if both
>> give the same pattern, its not disambiguous. If not try the next
>> pattern backwards.
>
> How does it catch the case where you have both 'xyzzy' branch and 'xyzzy'
> tag, which is the point of disambiguation issue Shawn raised?
Right.
