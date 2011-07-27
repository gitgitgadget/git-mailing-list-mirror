From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save data for continuing after conflict resolution
Date: Wed, 27 Jul 2011 23:33:30 +0530
Message-ID: <CALkWK0nL2Lv8xSBQ0uBM-kuiK-aWDCqPmYUuyn5B7rPZMj5iAQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-12-git-send-email-artagnon@gmail.com> <20110727050220.GG18470@elie>
 <CALkWK0=uA1ZRsmiVwmx_3HXL-v+Bi-ONPEk5kMsh1RG0ZeVQJg@mail.gmail.com> <20110727155654.GB29924@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 20:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8Sn-0005bI-TV
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 20:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab1G0SD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 14:03:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55086 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1G0SDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 14:03:52 -0400
Received: by wyg8 with SMTP id 8so1180790wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mnSNNEQGUsnUdNVTgYPD/AukvfdX0cfRu2ZxxDHkRH8=;
        b=YQgt33PF313JjjChJpaiC/tqzuhZLIrhQNUjQU4Hff9x8Q5s3tSf3KPGhgGGHbO1G/
         OFKf4S5aEiT/265DscGszuIpi+vKMGFDSbrMGxg2NtwlZ5BD9yeH2mYm1NDpcAgkWxmm
         6JRXS9WXGD9JxU5s8lv5uCrDRUJyg7Vyjlayg=
Received: by 10.216.9.134 with SMTP id 6mr62044wet.111.1311789830119; Wed, 27
 Jul 2011 11:03:50 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 11:03:30 -0700 (PDT)
In-Reply-To: <20110727155654.GB29924@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177988>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Junio complained about the warnings here [1], so I added MAYBE_UNUSE=
D
>> to suppress them temporarily. =C2=A0Would you really like to see
>> read_populate_todo and read_populate_opts being introduced MUCH late=
r
>> in the '--continue' patch?
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/176899
>
> Hmm. =C2=A0Yes, I suppose I would.

=46ixed.

> But as usual, what is relevant is not what I would like but what lead=
s
> to clear, functional, and maintainable code. =C2=A0It is from that po=
int of
> view that the MAYBE_UNUSED is most problematic --- it suppresses a
> useful and true hint when compiling that the codebase implements some
> functionality that has no user. =C2=A0For example, the warning would =
be
> triggered if the function gets renamed and added again and this old
> version is forgotten.

I actually think of it as a trade-off:
On one hand, I want to introduce functions to read and write
configuration files in the same patch.
On the other hand, I want to introduce functions when they're actually =
used.

-- Ram
