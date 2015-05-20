From: Stefan Beller <sbeller@google.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 14:13:19 -0700
Message-ID: <CAGZ79kab8a9H2SFaqi2PFLxhqH86wD35STPo0Jw7CyFe7e9tig@mail.gmail.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<20150520182218.GD14561@peff.net>
	<20150520183115.GB7142@peff.net>
	<xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY7wg1JjshwZOtWhm_0qP=CBQqvhqayZpvhu35WuMhxWQ@mail.gmail.com>
	<xmqq4mn7m00c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBIq-0004BU-PO
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbbETVNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:13:20 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35193 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbETVNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:13:19 -0400
Received: by qkdn188 with SMTP id n188so35955995qkd.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uQPa0hGgiT97W2xz4j6LJHNOnGtH0OBDzvorkx5lG44=;
        b=CPeYqBUZUWBGOhDuqAkGJqB9H3Y3pakMZ+UlzLzMzxZDXOgddUxl1pg9UWjOeX19kr
         59UAnmVnHPunR0rEnloOmjfQrGabmKVRt09xleBXzimR7XonzgFwJTxI3E7n7FSPeKxB
         RaojZKNNlg/PDu6cOtwm1dDqBJsH6Dh4sTn9+OFh7TNd8rxuveqBE62iS4S0XAHv5qMB
         XXNeel7tJHUhu1pgbpTfmbAeHUsBZm6xKzDfOF6KqcM01RMN1gvAljKWx2HA3NDcV8g6
         9WfPBt9HUFJEXfejxaUzJRa+77v/3/D0QttO5+tKRw4tu1Libm7J89cLoZrJWE21RNE1
         uyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uQPa0hGgiT97W2xz4j6LJHNOnGtH0OBDzvorkx5lG44=;
        b=mZqiTm0dPnjQDbg9CBtiX5eJSTHgva8BCtNstTsMPfsfMNYcA01M0FWwsb4sGMcPdf
         1pHmMcuMwALL3MHLTKJuqL+x4FF/yNXM1d7L81aNLfGT/fzMr16kLcmdWPovI7va7b+g
         AcZLJ882gm5TRMrPHUOYtUJtSRrj3UI0k7ye/IbnkDP1jIdhOjTCjDg9tnL17T4k+mB/
         jpOe08vz2k4fgkI1x/j/FPjeLh/z13h+bsWNvNhG0d+ON8CbdvQP7Va+0qaeN1sWznZb
         0pWoG6XYzFSoHi4VaViC2dT7rUXPr4saHLW3xzrb5lGhr6mI0eWxoLIM23KpTmNGpprT
         71Tw==
X-Gm-Message-State: ALoCoQl4bmjw1Ol3j+22GgPp+EYLhilnE1G9ltkqS6dgweKlZ6D6d4vDB5kvU0VGviuC5taRaDm3
X-Received: by 10.140.89.200 with SMTP id v66mr45128808qgd.50.1432156399258;
 Wed, 20 May 2015 14:13:19 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 20 May 2015 14:13:19 -0700 (PDT)
In-Reply-To: <xmqq4mn7m00c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269526>

On Wed, May 20, 2015 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, May 20, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> So...
>>
>> maybe we need a command:
>>
>> Given this SHA1, tell me anything you know about it,
>> Is it a {blob,tree,commit,tag}?
>> Is it referenced from anywhere else in this repository and if so, which type?
>> And if it is not referenced, nor an object, tell me so explicitely.
>
> Let me add another to that list ;-)
>
>   I have this prefix; please enumerate all known objects that share it.
>
> I do not know the value of the first two in your list.  If it is a
> known object, then you throw it at "git show", "git cat-file -t" and
> dig from there.  If it is not known, there is nothing more to do.

Right, I just tried to think of all the questions which are relevant to answer
in such a case, so probably this can be outside of

>
> I do not know if "need" is the right word, but I hope that you
> realize the last two among the four you listed need the equivalent
> of "git fsck".  It is an expensive operation.

Yes, I do realize that. The way I interpreted Faheems original message was:

    git fsck tells me everything is alright, but I don't trust fsck.
So now I want
    to find a way to ask Git about everything it knows about this
$SHA1 and print
    it for me so I can manually look at each entry and verify by hand.

So that's why I included the parts easily done with cat-file and show.
