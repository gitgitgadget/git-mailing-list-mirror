From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rewriting git-repack.sh in C
Date: Sat, 3 Aug 2013 17:03:52 +0700
Message-ID: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
References: <51FBB8CB.8020600@googlemail.com> <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
 <20130803063325.GJ19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:04:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5YhH-000638-EL
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab3HCKEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:04:24 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44866 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3HCKEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:04:22 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so3204790oag.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ek5+19AtCZylfe1UazwwWpx7kTRMBg/KJo8B6G1GPG4=;
        b=y/ITQjuUrj/wg5uJMN6ZCvMOnrCOrfXZkHIBqLPKQVxqdhd2cbxcbxcIa9gX+TOiwl
         MLwGPbNjxBKsj1IN0QJzb9U6AgHyI5ngP5xMC4wioQ1EVyIQu6gy/8c6/WAxxTZFHua7
         W2oT8idqWelS+uK7C6xrLFBZ98xTv6puXgSj5cUXHnBoSvfiY6vBTZuiUWBUUJH0N7kW
         v/wB0a9QpiL++oFsj620LTXgsO/nAdgCP9eURFdNokQDwO+QStLCcJ2Jgi5UbMn+vqdL
         N7RQaEnwQL29I1RaCC7Dxaahti60hZrbnppr4G6biOum5OfK2Jb1RK4Lu9+ypvtgHL4E
         QCrA==
X-Received: by 10.60.45.138 with SMTP id n10mr8157695oem.101.1375524262410;
 Sat, 03 Aug 2013 03:04:22 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 3 Aug 2013 03:03:52 -0700 (PDT)
In-Reply-To: <20130803063325.GJ19369@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231575>

On Sat, Aug 3, 2013 at 1:33 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Fri, Aug 02, 2013 at 09:10:59PM +0700, Duy Nguyen wrote:
>> > So my question is, how you'd generally approach rewriting a
>> > shell script in C.
>>
>> Start a new process via start_command/run_command interface. It's
>> safer to retain the process boundary at this stage. You can try to
>> integrate further later.
>
> Is it really the right approach to just replace sh with C? IMHO forking
> and wait for the result should not be done if it can be avoided. It just
> adds overhead.

Agreed. As I said in another post, I misread this as rewriting
git-rebase.sh, which is a lot more complicated.

> Of course you can argue that just replace sh with C is a good first step
> towards to actually do the command in "full C". Altough I'm afraid that
> that will get such low priority that it won't be done.

One of the reasons I started porting git-repack.sh since 2011 and
never finished it.
-- 
Duy
