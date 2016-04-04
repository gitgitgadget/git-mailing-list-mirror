From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Sun, 3 Apr 2016 21:38:34 -0400
Message-ID: <CAPig+cTccb8nr7sV1PKkEf30nRz123TTgeZXkac01RaRwqvTZw@mail.gmail.com>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
	<1459638975-17705-3-git-send-email-santiago@nyu.edu>
	<20160403044054.GB1519@sigill.intra.peff.net>
	<CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
	<20160403130724.GA16206@sigill.intra.peff.net>
	<20160403215847.GD28933@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 04 03:38:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amtTY-00054r-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 03:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbcDDBif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 21:38:35 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33687 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbcDDBie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 21:38:34 -0400
Received: by mail-ig0-f196.google.com with SMTP id nt3so11816221igb.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 18:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=icYpc3hmhDRClrTMqSKGYwftQ6hQGnKtgfurF+0orO8=;
        b=Gu2Mgj5jMTw4OGM1aZ6lKE6XimHrHTsUj04s8wrVzOkxPtcoXy84P7pKK+G5CRYnxb
         GZnqY1ErSDLk3WGWvljCaYgJ1N5bm5os8KAfAXX9WfBZP6kqC+n7Y494CiKeBrKkk2dw
         kQyDI6ZkCVyXZ5UdFhNbOxP4EiVzVxKNrRgUxG8e0zvUaahtgDZ+HiXJgKPAZncvH4g+
         XvXf1HDQClmsoUobtI5sA/iDyHIMq7yGtbudPAMPCO+5UCjhO2w5TPR6J0Qc91jRqn5U
         KkMSFDplwgpnt8wA+XQPtZJe1ndIiy2k5cSLsl98m5Kkt7+ejyhVHbHkRIAZgJ5vQkFq
         irMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=icYpc3hmhDRClrTMqSKGYwftQ6hQGnKtgfurF+0orO8=;
        b=Azg/kuLA5LrUpFl2mUMSes2fz3GZHv8afDdW9uz3QStflxTUoeNZYri1KY+pmXgFuQ
         +Ct4srMGe8o2xi/wV5qUvrMJCuqR49xm1W+ctsueE7vFzfcqd1LxA1GoPrfoDUIU7R7n
         LXmGIF5JlzHwQNYqKb37P0SZSenWWKXK8UUV3EOqLdAbVebrsbkPDrdOVhNCdJiWocTV
         oo05TohKzgxRkBvlxGX0WW8C4sNaz9//IE1HqinugU/9CaZJ46jRSPHLsMemLCRewr3z
         VGEns1G51lAGYBPzL6ulpRoHZXdKMRb72ANpOelTYDOmnkfZQDlIEuVo0u8o1NVAPycn
         x+/Q==
X-Gm-Message-State: AD7BkJLHfAjkkEmBy8ATFkyo7M1Dv7y3ch4mis+NrE908liq/BfrdKC2HIWwQTx7Ia2iGNUsP+5WY7aSu3SNxQ==
X-Received: by 10.50.138.8 with SMTP id qm8mr402448igb.17.1459733914109; Sun,
 03 Apr 2016 18:38:34 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 18:38:34 -0700 (PDT)
In-Reply-To: <20160403215847.GD28933@LykOS>
X-Google-Sender-Auth: Zk-es8YCWEofhMH3HAtZyoPhbjY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290667>

On Sun, Apr 3, 2016 at 5:58 PM, Santiago Torres <santiago@nyu.edu> wrote:
> On Sun, Apr 03, 2016 at 09:07:25AM -0400, Jeff King wrote:
>> On Sun, Apr 03, 2016 at 03:59:46AM -0400, Eric Sunshine wrote:
>> > On Sun, Apr 3, 2016 at 12:40 AM, Jeff King <peff@peff.net> wrote:
>> > > In fact, I suspect you could replace the "GOODSIG" check as well by
>> > > doing something like:
>> > >
>> > >   tags="fourth-signed sixth-signed seventh-signed"
>> > >   for i in $tags; do
>> > >           git verify-tag -v --raw $i || return 1
>> > >   done >expect.stdout 2>expect.stderr &&
>> > >   git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr &&
>> > >   test_cmp expect.stdout actual.stdout &&
>> > >   test_cmp expect.stderr actual.stderr
>> >
>> > Hmm, does [1] suggest that using test_cmp on stderr here would be
>> > contraindicated?
>> >
>> > [1]: http://article.gmane.org/gmane.comp.version-control.git/289077
>>
>> It does, but I am not sure I agree with the advice in that email in the
>> general case (I like making "-x" work, too, but not at the cost of
>> making the tests harder to read and write). In this case, I suppose you
>> could grep for gpg raw-output on stderr, though, and compare only that.
>
> I just read [1], I'll take the later advice and use test_i18ngrep
> instead.

I think Peff meant that a simple grep would suffice; no need for
test_i18ngrep. In other words (reproducing Peff's example), something
like this:

    tags="fourth-signed sixth-signed seventh-signed" &&
    for i in $tags; do
        git verify-tag -v --raw $i || return 1
    done >expect.stdout 2>expect.stderr.1 &&
    grep GOODSIG <expect.stderr.1 >expect.stderr &&
    git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
    grep GOODSIG <actual.stderr.1 >actual.stderr &&
    test_cmp expect.stdout actual.stdout &&
    test_cmp expect.stderr actual.stderr
