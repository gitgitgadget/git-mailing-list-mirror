From: demerphq <demerphq@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Wed, 17 Nov 2010 09:37:13 +0100
Message-ID: <AANLkTimp1ZvVLnRQa+LssbeO7F=9MrA56aZgFHQnbZCK@mail.gmail.com>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
	<20101116112406.GA18259@do>
	<AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 09:37:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIdW6-00059O-3K
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 09:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759595Ab0KQIhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 03:37:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37473 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758564Ab0KQIhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 03:37:14 -0500
Received: by qwh6 with SMTP id 6so1501135qwh.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 00:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VkaqEOJgUNhft8GG6R29kVHQEPH0T3KfAK7mKe2yWVQ=;
        b=g7g9MI4xRX5NS7PcfurIwtiebU0/7whvxWzu4W/83IPJe0pu+Au5aPf1qzWJ6+5RlP
         nPbvZFPIgdd/lRsiEcwrhbsExlRxaFx5V7lQdIL8AUIJg15j+S7scZd2N4Ol7vxB6zB1
         lfUc1p2d3Awm17HlIfGH3/kimXq89ATJtWwTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f5+XuGY2gAGoKZjPkyduPx5LM0KhS9fDcT5lkA1sicS2km90lyexnGQ0NnIhSQn0rb
         ZWIpFasxORwfSEjRfjgUMsAsTTMqoiMYFoCkDx8I8p7+Drv2lmgYFY7SWpYuK8RoXNre
         6WvVt57MBjrTlXbCvBl+jG9ZrbQcLWQdhj1z8=
Received: by 10.229.97.11 with SMTP id j11mr7391847qcn.113.1289983033625; Wed,
 17 Nov 2010 00:37:13 -0800 (PST)
Received: by 10.229.231.71 with HTTP; Wed, 17 Nov 2010 00:37:13 -0800 (PST)
In-Reply-To: <AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161603>

On 16 November 2010 12:34, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wro=
te:
> On Tue, Nov 16, 2010 at 6:24 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> +static int identical_content(struct cache_entry *ce, struct stat *s=
t)
>> +{
>> + =A0 =A0 =A0 unsigned char sha1[20];
>> + =A0 =A0 =A0 return !index_path(sha1, ce->name, st, 0) && !hashcmp(=
sha1, ce->sha1);
>
> Even better, do a file size check here. If it's not equal, there's no
> point in calling the expensive index_path().

I tried your patch, with the size check modification, and it seems to
work (meaning it passed all existing tests).

Ill try to put together tests and a proper patch soon.

Im hoping that if someone thinks that such a patch would be dismissed
out of hand that they will let me know....

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
