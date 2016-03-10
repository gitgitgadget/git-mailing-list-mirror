From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC v3] add a commit.verbose config variable
Date: Fri, 11 Mar 2016 03:19:19 +0530
Message-ID: <CAFZEwPN=4TD+jzmwJ3gyMq+3NURB_m-6-AhqXLO+Rvx19GTTtQ@mail.gmail.com>
References: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
	<xmqq7fhadnkv.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPP5_rBKH_=0pv_3PszLYtnznXeGJg1+yjwbiH0m_BqdZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:49:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8SS-0002sT-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbcCJVtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:49:21 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35063 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbcCJVtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:49:20 -0500
Received: by mail-yw0-f177.google.com with SMTP id g127so79115484ywf.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 13:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dLKa1zJkT6TTTKnT+q3H5tr4n0Yla92AzWBX/Ctela0=;
        b=fpVo+D9sfTFJxf0ZoMT41WugQPZDOza4tlYXjjZj8mNB+SfCztSAeDByoE6N3538b2
         /onsUjEfzCHuQZDg9NnoJeTxcp3rqDQqZtMyR06lm03+/+O9v3QdRyOwSArPYUMX8sHe
         942jxF0SRy/DMLXO0Txoj+aXeQqBE3MW/WP9HnWtDQZ65lHJS2pWryYx4iYWTMVQa3NL
         pbN367p4HFpGO26YFBo+fgCAsHnoj7XadqPno+HkKHpStO0nCBlrDLyOnsTzbKimXXHV
         Tx/gvWljr8CHQwnTezB5zciGnC/IMoqn0IoEe0SFoGmptBU0ET+vt5UgTA0qTaRuGBrV
         Io+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dLKa1zJkT6TTTKnT+q3H5tr4n0Yla92AzWBX/Ctela0=;
        b=JZ422KR+H1eYNsKO+YGlZ2nW2Nro21q6y45a9rKZ+O7SeKEg0kW+SeCdeFvynT3IzH
         F6yn37GF4MQZiShrpLNtDJw/LtcuDc+TZw5e5SsluMtyVOsWTaUIE77B4TFopVhpSbrU
         oQHetFIv7zs5TMkvpORDaeFwkhQKpGW3YBVodsQUOKJa+S2dF/6n3+TRcnzrufWrkkI4
         SU0ygUTdG5MtYqfPKYotD1nEs5EbgAnE5Jb2OXCAHJ+yu65BF5McIsj2JyHfj7UfOAjO
         YshqgW2UbFNYEoQad/QiWtCVLI/m1M39YW3b4WYcrXfBSbYf1DI1IT7dJVG0HoAU1Hcr
         PXJQ==
X-Gm-Message-State: AD7BkJKP6zhWUk2oM7+2wbOQRzUdfqQueZXjPTeMv9cscXxUKveajvH2+uR3eU0Ph7p73mpwDYhTQJ2X3+dhMw==
X-Received: by 10.129.94.7 with SMTP id s7mr3469803ywb.93.1457646559420; Thu,
 10 Mar 2016 13:49:19 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 13:49:19 -0800 (PST)
In-Reply-To: <CAFZEwPP5_rBKH_=0pv_3PszLYtnznXeGJg1+yjwbiH0m_BqdZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288649>

I figured it out, It first runs status_init_config(). I might have
thought "status" as status of the options and thus I may have edited
there.

On Fri, Mar 11, 2016 at 3:08 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Fri, Mar 11, 2016 at 3:04 AM, Junio C Hamano <gitster@pobox.com>
> wrote:
>> But doesn't this belong to git_commit_config(), not
>> git_STATUS_config()?  Should "commit.verbose" make output from "git
>> status" verbose?
>
> True. It should belong to git_commit_config(). My bad. But
> surprisingly this code works. I have no idea why. I will update the
> Patch and I have also finished writing test so I will include that
> also.
