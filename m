From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 3/7] vcs-svn: fix signedness warnings
Date: Thu, 31 May 2012 23:14:43 +1000
Message-ID: <CAFfmPPOoRfc9ZHuyQ+Qa0UDqARLLyXwqTxOOLr_2m8BbnzeEfg@mail.gmail.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
	<1337868259-45626-4-git-send-email-davidbarr@google.com>
	<20120524144847.GC3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:14:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5DE-0002hg-MG
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab2EaNOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:14:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58682 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab2EaNOn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:14:43 -0400
Received: by yenm10 with SMTP id m10so757047yen.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=kmqjzzyXwuCAE4Ud+tN1GKhPEfzAmxhNTalswQUGLso=;
        b=SpHKnpdemrhUvjFiDXnzHXLsxN33XLxoF8qst6v2ueiKUHOxPs/+o+6bFCdfVUwT4p
         NtT0zsIT1iYoz1ao0YuY5MgvryM59AkjEXzB93PtEs0DtFIhS9Lkevx7mBRdGEOEXIgL
         1iXKKSkLpSogNq+EJTcStAcAJNoWM1VrM3Ia7aPIxu2+sF0+FjIiJI7wkLD/8+wM9Aw5
         r/gXPyHD5YTD6TcjdOjFiljuKwEuLcoezig9nRhhOPV1xzHQsr+K+VdkrVlOKq+dH5h4
         GMP8kMnX1oLlUP3mc4jZFwgA0eJbnkBB/+J0Nf4rq5j2kcKFzSPDlbHRRQqYpv3NqMiF
         njyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=kmqjzzyXwuCAE4Ud+tN1GKhPEfzAmxhNTalswQUGLso=;
        b=LX+Y3RquvxF2n+MezxNajOA/s4uMh1xZ08jPcy/H/b03VfV5KbkpV+8ZmzsowHlMGL
         TAXyOlxhvHDYAg0NMl7RXHbcaHyd4YYUlpmRdT+5p8JuevKCGOGUxWJ79+J8oSuqJ2wg
         TJmtdzRXMQmw3NIAP5vZ4AZIxP4zChCFLDr4AXVbPWKXCY9e0l/oR5j5jij6Cti0EuL8
         6MH1CG+LNBGr+9K0ZeXAEedLpYiMd+jwJAIvmXBbcv86ircT1co2jZLXGb7bjYMqVnf3
         Bo6E6YcDSmNxuRj62aaGO7m+k7r6lD20sXPix4XTm8V2wYsnCWUYqJQuqOcnCPl9b/PV
         NG2A==
Received: by 10.236.187.2 with SMTP id x2mr2263461yhm.42.1338470083183;
        Thu, 31 May 2012 06:14:43 -0700 (PDT)
Received: by 10.236.187.2 with SMTP id x2mr2263451yhm.42.1338470083094; Thu,
 31 May 2012 06:14:43 -0700 (PDT)
Received: by 10.101.155.23 with HTTP; Thu, 31 May 2012 06:14:43 -0700 (PDT)
In-Reply-To: <20120524144847.GC3732@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlRZujlWaXmMznJxvLOEPVhJGhiKfPByynxe9TIa2XLXCnusCFUGPqEkT3G5HZnfoBUaQmxI3VYenhAzXdGDq9D5r11/Jjm9Z9qK9UWS1d/geXEZBwfQGujixZCTThXaPy8aoT/DaVk/MLZQkvWhHmfY3trXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198895>

On Fri, May 25, 2012 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> David Barr wrote:
>
>> --- a/vcs-svn/fast_export.c
>> +++ b/vcs-svn/fast_export.c
>> @@ -259,7 +259,7 @@ static int parse_ls_response(const char *respons=
e, uint32_t *mode,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* Mode. */
>> - =A0 =A0 if (response_end - response < strlen("100644") ||
>> + =A0 =A0 if (response_end - response < (off_t) strlen("100644") ||
>
> I wish the static analyzer could notice that "response_end - response=
"
> is always nonnegative and stop worrying. =A0If we want to appease it,
> I guess I'd mildly prefer something like
>
> =A0 =A0 =A0 =A0if (response_end - response < (signed) strlen("100644"=
) ||
>
> which expresses the intent more directly.

Noted.

> [...]
>> --- a/vcs-svn/line_buffer.c
>> +++ b/vcs-svn/line_buffer.c
>> @@ -91,8 +91,7 @@ char *buffer_read_line(struct line_buffer *buf)
>> =A0 =A0 =A0 return buf->line_buffer;
>> =A0}
>>
>> -size_t buffer_read_binary(struct line_buffer *buf,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct str=
buf *sb, size_t size)
>> +off_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb=
, off_t size)
>> =A0{
>> =A0 =A0 =A0 return strbuf_fread(sb, size, buf->infile);
>> =A0}
>
> On systems with larger off_t than size_t (think "typical 32-bit PC,
> since file offsets tend to be 64 bits"), this silently throws away
> bits. =A0I think the cure is worse than the disease.

Agreed, I'll implement a better approach when I update the series.

> [...]
>> --- a/vcs-svn/sliding_window.c
>> +++ b/vcs-svn/sliding_window.c
>> @@ -43,11 +43,11 @@ static int check_offset_overflow(off_t offset, u=
intmax_t len)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -int move_window(struct sliding_view *view, off_t off, size_t width)
>> +int move_window(struct sliding_view *view, off_t off, off_t width)
>> =A0{
>
> Likewise. =A0I'd rather the caller know that the window has to fit in=
 an
> address space which can be smaller than the maximum file size.
>
> Is this to avoid having two different functions that parse a
> variable-length integer, or is there some other reason?

Nope, just me taking the wrong approach.

I'll submit an alternate patch, which much shorter and less worrying.

--
David Barr
