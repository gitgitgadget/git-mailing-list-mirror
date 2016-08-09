Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A161F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbcHIR0f (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:26:35 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37226 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbcHIR0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:26:34 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so20791288ith.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 10:26:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MhiJIb80hxyaVheaYSTXeGd9GyZgKySZYjX8OzI0J18=;
        b=o8W7DEFALxYhn0Rc1PowmNT11zX9vItcluMimW1O6JhijPszZu54Wp0FWPMaJPtpxA
         Ox/+5NxPaDj2fuuySKmm+LFXnHjk57aTAW+VE4o45s2/5Dy7D0c0IhIWurTiBfAuuUM4
         QRk+93kAb0Rha7vRXvb2UddM8UYX6erD7TJzrqyfx2UHcre1vfsWuBaLey+fUZXo30g8
         TBB866sSO9BLlUL+oyjGfXz8+G7k5veS3Lp+Jr4GJX/AL3djOYD1eQoEtWKrFIgVBSAv
         SYENbZ9viy7R37UisvYA6RoTBVUQzN8wZk+hlXZNaZqGQUTlW1xGmvTY4JsNMrc/OVPo
         X1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MhiJIb80hxyaVheaYSTXeGd9GyZgKySZYjX8OzI0J18=;
        b=khtcHqJMNbVCJxFRhDdpebfjMj+yiqWOSnvIm+OLxeS/0HgiMt7pam6AmcHlogC6UT
         YumUAf8epKydNSOlxBQBE6a4At/1ldXgdg9nPk8M+YAsUwEA0VEvXjo8ZvqGiiZxUTIb
         92mGqOZmqqncVZtOE2Io7XlZhTuEYz3yIWRGfU4edzHP2u78UdQRrZOvc1bHCO4vG9sf
         PEn2xZWXiKynww5El9nYYWzrUGVVL4nt2Veehl1T/P0Fym1HmypgpVM5QRFNrIy/kwrR
         5uFIlxpRdZDqDNJ3RWSLz8fpSRKvyI5a08Rufu89bMHRq0M9Ok4d4mm7vXMK2JuGwxL9
         9uFw==
X-Gm-Message-State: AEkoousG8B/d0ih1pt648YvnMnx+O2Qcrgp6CsOQ0M5FXfN1E1BYtCL4mE+q/gVjzyh4LogtWwHcYpy8PY+ZMVa/
X-Received: by 10.36.227.13 with SMTP id d13mr150965ith.97.1470763593413; Tue,
 09 Aug 2016 10:26:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 10:26:33 -0700 (PDT)
In-Reply-To: <xmqqy445c2sw.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <20160809040811.21408-3-sbeller@google.com>
 <xmqqy445c2sw.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 10:26:33 -0700
Message-ID: <CAGZ79kZj=M-kwZugL7Eo4Fk2t7i1AXTshkYSWKN0Rj=-F6qGHg@mail.gmail.com>
Subject: Re: [PATCHv3 2/9] t7408: merge short tests, factor out testing method
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, mst@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 9:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +# The tests up to this point, and repositories created by them
>> +# (A, B, super and super/sub), are about setting up the stage
>> +# forsubsequent tests and meant to be kept throughout the
>
> s/forsub/for sub/;

ok.
