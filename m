From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Tue, 2 Jun 2015 11:04:52 -0700
Message-ID: <CAGZ79kYg0W7biSXV1VH8NKcG=YNpotvbB7GD5-JAg8hEq0LOuw@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-11-git-send-email-sbeller@google.com>
	<CACsJy8Dped78Db0Pb455-dxha4aaQnSWDN_TwRpe9miVmwHcjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqYc-0003Jy-NB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbbFBSEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:04:54 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36788 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbbFBSEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:04:53 -0400
Received: by qkx62 with SMTP id 62so105342086qkx.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P9gJLq5tkRmQMvlDVhVh9rs5qg6AjNUTKkzPVJbylNE=;
        b=VFXR5YxVzc3BjzATU2pemzm8ovjfdiDUQ3MpHHS4YwoHtM/mYgqSZw6ptJP0rYLxNj
         d+mK4hhI7zGJsOzMy/EB8HP5IGY+fu7RjKCqSfF7ZqByQ0Ctlm/xQmzHDXMW3onCjxQt
         veV3wsvfFANQGjcfbraN8kLf0kG/a8Q5CCB3Igiv2ztehf+W0JcOgzFrwwRQ/GtlFwwA
         7/z00XgYUDxrpAG/DBcCmgNoGSy32wHgpEtj8TRmaCPCcW3A8t4h8IqrpGPu32h7J110
         i00es+RZw4iy/RRql8dcDEqEosV85Nw0hLhO4IzgPA0YVKz2EIvEN0gBoRBHQzZRRXIw
         GciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P9gJLq5tkRmQMvlDVhVh9rs5qg6AjNUTKkzPVJbylNE=;
        b=bNxtyau7h38CraAbX35zDsHcbaHXpzM7Yk0vXZ712JBdHYMDLg2PyM7zFEo8eN2B8Q
         TIT4AtJ3T4Um6SlpJj1EN3WAeqRBSoVwtDbSSpFVWa3yI7wrAvtwSPPkj1T48mFjaIJP
         jZqBLi4iNUtb+eeIEpL5HmKkAAwZOS2ZoSRnebZzYzE5fwSCjLDdN7c7bw+PGZ/+QpdS
         lMNC2eBDNyoLtkvKxcE+UQ8ocPH8oW/VJztF1SDLSNGeUvzK/fmNdZqrA0SQyqxkbCyN
         sCYUA6j7AIrSJvmoBZeJt8pZKuUfYPwEHA1jEfwMt9cz0ZOCyhF4y1gvaGYu3gP6WoHH
         X1OA==
X-Gm-Message-State: ALoCoQn7fWhxHUJQdgxWnHNRmiFMQ+HY4rluohCPIdE7+GiZw6LhvNeSb4GDTMqfyvsmsCaPl3Qv
X-Received: by 10.55.19.197 with SMTP id 66mr50405431qkt.24.1433268292559;
 Tue, 02 Jun 2015 11:04:52 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 11:04:52 -0700 (PDT)
In-Reply-To: <CACsJy8Dped78Db0Pb455-dxha4aaQnSWDN_TwRpe9miVmwHcjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270574>

On Tue, Jun 2, 2015 at 2:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     name it to_free
>>
>>  transport.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/transport.c b/transport.c
>> index 651f0ac..b49fc60 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -496,15 +496,28 @@ static int set_git_option(struct git_transport_options *opts,
>>  static int connect_setup(struct transport *transport, int for_push, int verbose)
>>  {
>>         struct git_transport_data *data = transport->data;
>> +       const char *remote_program;
>> +       char *to_free = 0;
>>
>>         if (data->conn)
>>                 return 0;
>>
>> +       remote_program = (for_push ? data->options.receivepack
>> +                                  : data->options.uploadpack);
>> +
>> +       if (transport->smart_options->transport_version >= 2) {
>> +               to_free = xmalloc(strlen(remote_program) + 12);
>> +               sprintf(to_free, "%s-%d", remote_program,
>> +                       transport->smart_options->transport_version);
>> +               remote_program = to_free;
>> +       }
>> +
>
> It looks to me that the caller should pass "upload-pack-2" here in
> data->options.uploadpack already. We should not need to manipulate the
> uploadpack's program name. Not sure how complicated it would be
> though.
>

I tried that before as it seemed to be the better approach to me. But
there are multiple
occasions where you can overwrite the "upload-pack" string. It can be
a repository
option or globally configured or coming from a command line argument.

And keeping track of all these places and both passing around the
version number as
well as the binary name seemed cumbersome to me when seeing my implementation.
This way we only have a very small change and you can tell the version
number from
the name, which is an advantage (the version is fixed and will not be
negotiable, so you
need some way to tell the protocol version and the name seems to be
the obvious choice).

So if there are no strong arguments for doing it the other way, I'd
like to keep it this way.
