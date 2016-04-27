From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Wed, 27 Apr 2016 16:24:41 -0700
Message-ID: <CAGZ79kYRhk8bH7+rGRjfvwk=HHy8=Yfg_P54pp8Goeb-bO1wSw@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
	<xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
	<xmqqzise7o4l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kagX5TJU_mbjpo4PKJDoc1wh24DhyS814Kkq76EU9aykA@mail.gmail.com>
	<xmqqbn4u7ibp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:24:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avYp4-0001fz-W0
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 01:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbcD0XYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 19:24:43 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34063 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcD0XYm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 19:24:42 -0400
Received: by mail-io0-f182.google.com with SMTP id 190so56040843iow.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 16:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7vkljwrn+CBMSf65ytER+40hT+q+wHg4wAB2669CO0c=;
        b=PhcyjY9xkAxzYHIgUonGvkH75RtZf7b656dsa/OhSXaFRbxFlZiiIOunH6/JAHQfay
         gNFWMM24fjMSzj1WSFsTEcd9tPNhllc/JuJTBM2V8tx9h2fSbPPPxEnGYIkaEB0Xn2Yo
         G+NBp2q7+VSfFeoViqe+XQFnC6DpRnua/GEcTE0a7jFHVhaMTEDgaDbPEOEc3aJhJcfZ
         MhnIeTxNzUX1ruApIkp62WiPRPsU7/fLHeU6fWuoVF09FWWA4WlZQKLy2LX/ZP4jjsPc
         leG6KTXrHSVAVualjvKKVWAPLdmss8Fk8DneJurkjyn3fOYhPruRPO9ITSkU+OgP3/gZ
         W6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7vkljwrn+CBMSf65ytER+40hT+q+wHg4wAB2669CO0c=;
        b=EAbEOIrUd+x8t0VDADbmZFR9TVQf9JULED4zfCEhTwPd59SJY6TmhdbMNYKFtF5h/L
         jG4gL7YcbhX1Un7cuFaO43draLOJ2s6opNHdSKXkYeddwVWQW6+PMhsc5oQHuxCOmCWC
         8TFMsegue/YvwuVFGFhHZS+yTi1hS4WMxnzulTvyO4JVLqa0pG0HrC3f4L6vCUkHIXV1
         RuRsEMff1pu/xwGh6jE+SgkKwsy+Fql6+gGFW+Twpml2I8Qcysh0/vxXJSmDlgfVSuDv
         7SZgomYEIfd318iG5rFsj8X5oTFpKSAppKiO1E8mpwdJ5iOPHq3Tf4PKCfwWovMOlMMR
         BrMg==
X-Gm-Message-State: AOPr4FWtFhzDPlnhavpOfDpqlALhfgGueH43TF7Cmei+sDSjlu5vHEXd1noLNpMp/1T08+b6mSDDuFf2jTxNtHCG
X-Received: by 10.107.53.200 with SMTP id k69mr13330300ioo.174.1461799481265;
 Wed, 27 Apr 2016 16:24:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 16:24:41 -0700 (PDT)
In-Reply-To: <xmqqbn4u7ibp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292841>

On Wed, Apr 27, 2016 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Another way to corrupt it is to change the configuration (e.g. add
>> things to the config hashmap such that it reallocates and grows).
>
> You're right.  But doesn't it hint that there is a deeper problem?
>
> By making a copy and keeping it, you would hold onto a stale value
> and would not see the result of updates you yourself make to the
> system.
>

In this case the value doesn't go stale. We do not change
"submodule.defaultGroup", but only new submodule.$NAME.url
and such. The memory for accessing it goes stale, so in this case
it is okay. I don't think we want to see repeated calls to
git_config_get_value_multi
like :

        if (!pathspec.nr && git_config_get_value_multi(
                        "submodule.defaultGroup")) {
                gitmodules_config();
                for (i = 0; i < list.nr; i++) {
                        const struct submodule *sub =
                                submodule_from_path(null_sha1,
                                                    list.entries[i]->name);
                        group =
git_config_get_value_multi("submodule.defaultGroup")
                        if (submodule_in_group(group, sub))
                                init_submodule(list.entries[i]->name,
prefix, quiet);
                }
        }

Maybe I am overestimating the cost of git_config_get_value_multi, so it is no
problem?

Thanks,
Stefan
