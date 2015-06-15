From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sun, 14 Jun 2015 23:08:44 -0400
Message-ID: <CAPig+cRouQOgd29qQZSUo0t+NBPfeKWD+4j42pArLW3TpND=bQ@mail.gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
	<1433874279-30720-3-git-send-email-erik.elfstrom@gmail.com>
	<CAPig+cTQKxD9WRV3spVce=SfeECo4XR_ujZ1sGecuhTL-3DeRw@mail.gmail.com>
	<CAMpP7NZ2tqZ5cv=9=gJqDZ5m0LOZtsHGvt-ntZcp6cBA6X5tqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 05:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Klf-0002ys-Re
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 05:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbFODIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2015 23:08:48 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34369 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbbFODIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 23:08:45 -0400
Received: by yhid80 with SMTP id d80so34432340yhi.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=LQFmcIDwUVfGpbWkwE4iUabqTs5J3GZrkuh2ud5W2uQ=;
        b=GHO8XbnVEOGwcpkLb74Cp7F1OwOhy9pxyVYnGUAamrWtXyHI7lh2JoAoDWknfH1WGs
         HFb8VsnsHkr9CrPcR5wC8Je5XrMTKUA51nsNzJxy1UkyZF4JRwoszFmGsc81KEM9v8A6
         FECd1RKnJpm7b/WICzqY62VV6y/lDJ09tIDwzxlfzqD1b1Er72Y5QzbgaHc6XQJBu2b6
         yX1LpmOe32iixtE88mq2KEfNQa3OSWSBDRCVtkzUSRlGRREuyqBdb25Pyu4nqV6i+vyM
         8S0/ao17QB0la3lR0xjPPzAwY+YtJlwpQkLuSAd1/+RiXyahmPs4tEJ+ITavn6pJi8Uu
         Sbsw==
X-Received: by 10.129.70.137 with SMTP id t131mr31769901ywa.4.1434337724807;
 Sun, 14 Jun 2015 20:08:44 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Sun, 14 Jun 2015 20:08:44 -0700 (PDT)
In-Reply-To: <CAMpP7NZ2tqZ5cv=9=gJqDZ5m0LOZtsHGvt-ntZcp6cBA6X5tqg@mail.gmail.com>
X-Google-Sender-Auth: RsEEsbuS2b2ntejTKjS1BpZ8Y2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271658>

On Sun, Jun 14, 2015 at 1:21 PM, erik elfstr=C3=B6m <erik.elfstrom@gmai=
l.com> wrote:
> On Sun, Jun 14, 2015 at 5:42 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>>
>> This variable name doesn't convey much about its purpose, and
>> introduces a bit of maintenance burden if the limit is some day
>> changed. Perhaps "sane_size_limit" or something even more descriptiv=
e
>> (and/or terse) would be better.
>
> Would you be happy with this change?
>
> -       static const int one_MB =3D 1 << 20;
> +       static const int max_file_size =3D 1 << 20;  /* 1MB */

Yep, that's a much nicer variable name. Thanks.

I also note that 'const int' shows up pretty frequently in the git
source code, but 'static const int' is used only very rarely.
