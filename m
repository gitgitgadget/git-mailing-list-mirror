From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 1/9] receive-pack.c: add documentation for atomic push support
Date: Tue, 30 Dec 2014 00:33:22 -0800
Message-ID: <CAGZ79kZ_yiA7tMv49qp3OOMfOmwdaDtWs_Gt9V359xCKUE_SJg@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-2-git-send-email-sbeller@google.com>
	<CAPig+cQ7GhrZqXH3zRYTWjwuWKwDNNwLRKG516dXS6et2TURgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sHJ-0002Lp-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 09:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbaL3IdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 03:33:25 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35535 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaL3IdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 03:33:23 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so12299337igi.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A8ndkB1GJIRRYs4kXebbA+bYdQoOBI8lKE2Jyr1cszE=;
        b=kLTFl/3M09gweeCYAWPNL919a2Lp28XeEkscon+/SWObAgf2iKCiiJPRBqq36MQ5H/
         ZgZ8vKo2m9Rh0sda/g7BtR9iHC1XDe+nDsbY8okKNGzniy1wtoFceqDMbLhLqC9iYhAe
         o1PMd9l/FAobmJjlBFfUf6HwhgwN+5LM4TOYf3RXCeqGEKfw2NwleV/DB4XnNsJ73EbJ
         TVj6DSzhYx3bqo2u7RwDOF7/6Gm5+GvKVsZMcgFIEzgPgHIQdFHOcrAM3rIrG6WQHUdI
         n64IUEoFgqii4WdyzFrxKC5CIEKnlfXWe99lptvDjAEhnLG017NrpEHFVWkDySOXTDm3
         a7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=A8ndkB1GJIRRYs4kXebbA+bYdQoOBI8lKE2Jyr1cszE=;
        b=ZHZWprIKcUsg/1ruZ4c0Umfw8lAUqCTYro2NLPyblT/F+UBlDJNanqyuDVt8fJCOHh
         2nlr64mfgFC6dAQcW3S37P6LjoFLqKixaoQHd/7SSlEVzNGpUmldh7+UH2ecFhCAnTQx
         BTHq06EKTMgMTqad6y9Hr7QocUQiHLc+I1dX+k+evUmvEYsSjdCpQd/3lheMZ0dmnl5b
         PbWs1Va3QpB24J1060CDREwn24OjDYMxzWchjNjvZaKe/+6cbJ0KDBn8HyJnSaOf3IZm
         2MA/IP1BYxYB2j9QlqduC45AbqS+3pOmcU6B67Rb65NgXU5EOVWeahqkeD0uw+0GEQet
         GaTQ==
X-Gm-Message-State: ALoCoQkQoB4XBqGmpWBv76++mMIhFlgFjvF28Cy51n+eNsgrQbSMEIIYcn09OFbY2wYzixIALlUY
X-Received: by 10.50.142.38 with SMTP id rt6mr39160137igb.25.1419928402475;
 Tue, 30 Dec 2014 00:33:22 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 00:33:22 -0800 (PST)
In-Reply-To: <CAPig+cQ7GhrZqXH3zRYTWjwuWKwDNNwLRKG516dXS6et2TURgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261915>

On Mon, Dec 29, 2014 at 11:08 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>> Subject: receive-pack.c: add documentation for atomic push support
>
> This patch is doing a lot more than merely adding documentation. It's
> also updating send-pack and receive-pack to be able to negotiate the
> new protocol capability "atomic". The fact that you removed the actual
> advertisement of "atomic" from this patch doesn't turn it into a
> documentation-only patch.

That's true, though the code itself is dead code and doing nothing in
that patch.

>
> When Michael raised the issue of the server being "broken" due to
> advertising a capability which it does not yet implement, his
> recommendation[1] was to reorder the patches, not to split out the one
> tiny bit (capability advertisement) from the larger change. Was there
> an insurmountable conflict which prevented you from reordering the
> patches? This is a genuine question since splitting off advertisement
> -- and only advertisement -- to a patch later in the series smells
> like a least-resistance approach, rather than a proper solution to the
> issue Michael raised.

Well there was no syntactical problem (i.e. the interactive rebase
went flawless),
but rather a semantic dependency. The reordered patches would not compile
as we'd heavily depend on the use_atomic variable.

Of course that could have been introduced where required, but at the
time it did
not look appealing to me.

I'll reword the commit message header to mention the negotiation part as well.

>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/261793
>
>> This documents the protocol option between send-pack and receive-pack to
>> * allow receive-pack to inform the client that it has atomic push capability
>> * allow send-pack to request atomic push back.
>>
>> There is currently no setting in send-pack to actually request that atomic
>> pushes are to be used yet. This only adds protocol capability not ability
>> for the user to activate it. The capability is also not yet advertised
>> by receive-pack as git doesn't know how to handle it yet.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
>> index 6d5424c..4f8a7bf 100644
>> --- a/Documentation/technical/protocol-capabilities.txt
>> +++ b/Documentation/technical/protocol-capabilities.txt
>> @@ -18,8 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
>>  and server advertised.  As a consequence of these rules, server MUST
>>  NOT advertise capabilities it does not understand.
>>
>> -The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
>> -are sent and recognized by the receive-pack (push to server) process.
>> +The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
>> +capabilities are sent and recognized by the receive-pack (push to server)
>> +process.
>>
>>  The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
>>  by both upload-pack and receive-pack protocols.  The 'agent' capability
>> @@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
>>  reporting if the local progress reporting is also being suppressed
>>  (e.g., via `push -q`, or if stderr does not go to a tty).
>>
>> +atomic
>> +------
>> +
>> +If the server sends the 'atomic' capability it is capable of accepting
>> +atomic pushes. If the pushing client requests this capability, the server
>> +will update the refs in one atomic transaction. Either all refs are
>> +updated or none.
>> +
>>  allow-tip-sha1-in-want
>>  ----------------------
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 32fc540..4e8eaf7 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -40,6 +40,7 @@ static int transfer_unpack_limit = -1;
>>  static int unpack_limit = 100;
>>  static int report_status;
>>  static int use_sideband;
>> +static int use_atomic;
>>  static int quiet;
>>  static int prefer_ofs_delta = 1;
>>  static int auto_update_server_info;
>> @@ -1179,6 +1180,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
>>                                 use_sideband = LARGE_PACKET_MAX;
>>                         if (parse_feature_request(feature_list, "quiet"))
>>                                 quiet = 1;
>> +                       if (parse_feature_request(feature_list, "atomic"))
>> +                               use_atomic = 1;
>>                 }
>>
>>                 if (!strcmp(line, "push-cert")) {
>> diff --git a/send-pack.c b/send-pack.c
>> index 949cb61..6d0c159 100644
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -294,6 +294,8 @@ int send_pack(struct send_pack_args *args,
>>         int use_sideband = 0;
>>         int quiet_supported = 0;
>>         int agent_supported = 0;
>> +       int use_atomic = 0;
>> +       int atomic_supported = 0;
>>         unsigned cmds_sent = 0;
>>         int ret;
>>         struct async demux;
>> @@ -314,6 +316,8 @@ int send_pack(struct send_pack_args *args,
>>                 agent_supported = 1;
>>         if (server_supports("no-thin"))
>>                 args->use_thin_pack = 0;
>> +       if (server_supports("atomic"))
>> +               atomic_supported = 1;
>>         if (args->push_cert) {
>>                 int len;
>>
>> @@ -328,6 +332,10 @@ int send_pack(struct send_pack_args *args,
>>                         "Perhaps you should specify a branch such as 'master'.\n");
>>                 return 0;
>>         }
>> +       if (args->atomic && !atomic_supported)
>> +               die(_("server does not support --atomic push"));
>> +
>> +       use_atomic = atomic_supported && args->atomic;
>>
>>         if (status_report)
>>                 strbuf_addstr(&cap_buf, " report-status");
>> @@ -335,6 +343,8 @@ int send_pack(struct send_pack_args *args,
>>                 strbuf_addstr(&cap_buf, " side-band-64k");
>>         if (quiet_supported && (args->quiet || !args->progress))
>>                 strbuf_addstr(&cap_buf, " quiet");
>> +       if (use_atomic)
>> +               strbuf_addstr(&cap_buf, " atomic");
>>         if (agent_supported)
>>                 strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
>>
>> diff --git a/send-pack.h b/send-pack.h
>> index 5635457..b664648 100644
>> --- a/send-pack.h
>> +++ b/send-pack.h
>> @@ -13,7 +13,8 @@ struct send_pack_args {
>>                 use_ofs_delta:1,
>>                 dry_run:1,
>>                 push_cert:1,
>> -               stateless_rpc:1;
>> +               stateless_rpc:1,
>> +               atomic:1;
>>  };
>>
>>  int send_pack(struct send_pack_args *args,
>> --
>> 2.2.1.62.g3f15098
