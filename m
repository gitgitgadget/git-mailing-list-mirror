From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] git-p4: fixing --changes-block-size handling
Date: Mon, 8 Jun 2015 15:32:46 -0700
Message-ID: <CAPc5daUFM+46tdPPmRTRu17UvDbyCGrhx_BDEnSepBMgS2r4ag@mail.gmail.com>
References: <55747A05.3070704@diamand.org> <1433712905-7508-1-git-send-email-luke@diamand.org>
 <1433712905-7508-4-git-send-email-luke@diamand.org> <CALM2SnZShkETQoQuNc8e0GsPWzODQACzwjh1qCGeajiN+5sjaw@mail.gmail.com>
 <xmqqk2vecho1.fsf@gitster.dls.corp.google.com> <CALM2Snb9nxT9_shhsGBJ6nuSOninKbKC-+GXKwmd=rkuLuLXzw@mail.gmail.com>
 <xmqqy4juazkz.fsf@gitster.dls.corp.google.com> <5575E264.6040601@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lex Spoon <lex@lexspoon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z25bg-0000YC-9t
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbbFHWdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 18:33:09 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35241 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbbFHWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 18:33:08 -0400
Received: by oihd6 with SMTP id d6so866613oih.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Iay+X24Z/ugQf2k7STU1yKw6h9wIDIz+qlGXzHjsucI=;
        b=AST8jFxxDeCYLpg8yvfYBcguDlXGnOAAyFmKzSZF1OzUus/O5/HK2Os8PI6RK0GZRZ
         T5Gy0JZi3ZXj9N1Ok8x+ca9poXzJEYEQyotF5SRhUgfU/pjSEot6J7JnqLTw/9Gc+vzK
         ilOGxI7EAnGN1PwqdNJ0JvtaxJsg5gopRrx2opW2J/8vdwmF2qxj5lz+OCtvdhjW5/cU
         maelfdL1v5Vn1VbESKxh3zUexXMl4noMwILe1DYNL+o22nL+dyfV7+OvzQ15yxDTnRQW
         uVDR1YHfjOeXD2hI8lFM/+2hr5/uczFLFnwUN2Xif2dB0GqwQQ7E0mEU/F1s8U17aORr
         wTdA==
X-Received: by 10.202.98.193 with SMTP id w184mr15366901oib.96.1433802787367;
 Mon, 08 Jun 2015 15:33:07 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Mon, 8 Jun 2015 15:32:46 -0700 (PDT)
In-Reply-To: <5575E264.6040601@diamand.org>
X-Google-Sender-Auth: teX0XqC2wYESFJWikFlmFfVUPA8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271142>

On Mon, Jun 8, 2015 at 11:43 AM, Luke Diamand <luke@diamand.org> wrote:
> On 08/06/15 18:18, Junio C Hamano wrote:
>>
>> Lex Spoon <lex@lexspoon.org> writes:
>>
>>> Precisely, Junio, that's what I had in mind. The patch with the two
>>> lines deleted LGTM.
>>
>>
>> Thanks, will do.
>
>
> I don't think we're quite there yet unfortunately.
>
> The current version of git-p4 will let you do things like:
>
> $ git p4 clone //depot@1,2015/05/31
>
> i.e. get all the revisions between revision 1 and the end of last month.
>
> Because my change tries to batch up the revisions, it fails when presented
> with this.
>
> There aren't any test cases for this, but it's documented (briefly) in the
> manual page.
>
> I think that although the current code looks really nice and clean, it's
> going to have to pick up a bit more complexity to handle non-numerical
> revisions. I don't think it's possible to do batching at the same time.
>
> It shouldn't be too hard though; I'll look at it later this week.

[jch: adding git@ back]

Thanks.
