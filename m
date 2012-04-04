From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 4 Apr 2012 11:44:24 +1000
Message-ID: <CAFfmPPOqb8Kn-LERyiLKL838DKw=X6=CTV1x0s8coPgAvNLUdw@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 03:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFFHB-00026i-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 03:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab2DDBo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 21:44:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42565 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab2DDBoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 21:44:25 -0400
Received: by obbtb18 with SMTP id tb18so495082obb.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 18:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=Y0anSa+rvVOZ3gG9zRrNkxhEKqRCHuoK2Y1AbS5cMPA=;
        b=AIB5wkzAM+804CdJSCx5hQVR74tXA3J1TL4Ujb+PUB9Ynxot/xFcnkV0P6uNsVbKVk
         i1o899ZhpufbRMerbiA0YZ6Lh9gnHWgXSv/Be+1TUWAUbviuPM2XgkFYkmNjQNmd/J//
         6HZMO8IIvstUl5kyHp9235JY6SHp+c64GZHyXtqtoL9GFjsWfbK++j5XUXoMTDHkZLyI
         ioGR8n7LFhpDG8OCxFLPpCuKUVDYfwb5fJdVoTJTEpThPND+ic0sLZgDFnt8eCi2q6Xg
         Orff+IsueyzRf/M+vR3UguXahei4vVPwhEiCLmWYHps6OvWdwzkx/jjwbOUrvq6iUKiE
         g0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=Y0anSa+rvVOZ3gG9zRrNkxhEKqRCHuoK2Y1AbS5cMPA=;
        b=UPaDSKT+k7bZ0JNlsCPgfE7N/Xkibai+P0cO6Q6vd363TwOsvrPDxZMk0MekSSkBTY
         H2MkwclobeEUc3F9BOEAQK7BL6ABbxeaUE1u9kS6+EOwp3iGXVz90somYRCyRIeAkMCO
         ow3nXV67U8iaacerATUPAvlRjQCTImLxaP1UM0t2zfTTOS13wtzuozChMp6QAJ7duBrv
         FNGL5rplbkoqBwD5H3orAC+eSDdCepVsQMo4iF20yS8LuHO3E3WdyC4l4A+LiqUIjT3K
         4uMgumYaTvxCWqau21W74eECDtjUWLQlj088uwJ3Off+bIYsjOOItkAcZfzxfLk8kOlS
         WYkw==
Received: by 10.60.4.162 with SMTP id l2mr23022716oel.3.1333503864934;
        Tue, 03 Apr 2012 18:44:24 -0700 (PDT)
Received: by 10.60.4.162 with SMTP id l2mr23022706oel.3.1333503864825; Tue, 03
 Apr 2012 18:44:24 -0700 (PDT)
Received: by 10.182.32.129 with HTTP; Tue, 3 Apr 2012 18:44:24 -0700 (PDT)
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmYaV+Q5objfqFrwMZk3kiBrLYMQGym3+i0Kysy+RmrkMs+uk4RiRkn8EvK1bxsSNBo/csVU8G05BjP05ip+IJil+SyDpwdeGFroNPzbW0UhLJcahkxycW+6AosfvpdBQUnyf+R6DWMxcCS/4ncK8P6rl1LHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194676>

On Wed, Apr 4, 2012 at 8:53 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> This is still rough, but with this patch I am getting:
>
> =A0 =A0$ ls -l .git/index*
> =A0 =A0-rw-r----- 1 jch eng 25586488 2012-04-03 15:27 .git/index
> =A0 =A0-rw-r----- 1 jch eng 14654328 2012-04-03 15:38 .git/index-4
>
> in a clone of WebKit repository that has 183175 paths.
>
> With hot-cache with no local modification:
>
> =A0 =A0$ time sh -c 'GIT_INDEX_FILE=3D.git/index-4 git diff'
> =A0 =A0real =A00m0.469s
> =A0 =A0user =A00m0.130s
> =A0 =A0sys =A0 0m0.330s
>
> =A0 =A0$ time sh -c 'git diff'
> =A0 =A0real =A00m0.677s
> =A0 =A0user =A00m0.290s
> =A0 =A0sys =A0 0m0.370s
>
> which is mesuring the time needed to read of the index into in-core
> structure and comparing the cached stat information taken from lstat(=
2).
>
> The updated format is not documented yet, as I didn't intend (and I s=
till
> am not committed) to declare a change along this line the official "v=
4"
> format; I was merely being curious to see how much improvements we ca=
n get
> from a trivial approach like this.

As I am hacking on WebKit daily, I'll try out this series and give feed=
back.

--
David Barr
