Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DB7203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 12:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755700AbdGXMuS (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 08:50:18 -0400
Received: from fallback10.m.smailru.net ([94.100.178.50]:51871 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755544AbdGXMuR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 08:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=yn2qji3mwnk0z8ugmNv54n6kzsF4WXQSQ3KxCES65yY=;
        b=NwOgTJRKFtodoGU1hYFnHJO/UoM7a+06/SeLYnxKKbVUke2vAckFdzP4UY3Whdq3D4aBceuxl82jShVp4ZFdHzv1s4sGyDdXby99wQ0MahxOToI+Kq/e1+t15mEZh2eOHrvl6RQxVNl9UBz+B/u1Yp/CvC2CnVfP8oXMP1vipL0=;
Received: from [10.161.22.27] (port=48226 helo=smtp57.i.mail.ru)
        by fallback10.m.smailru.net with esmtp (envelope-from <stsp@list.ru>)
        id 1dZcoP-0000H5-W5
        for git@vger.kernel.org; Mon, 24 Jul 2017 15:50:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=yn2qji3mwnk0z8ugmNv54n6kzsF4WXQSQ3KxCES65yY=;
        b=NwOgTJRKFtodoGU1hYFnHJO/UoM7a+06/SeLYnxKKbVUke2vAckFdzP4UY3Whdq3D4aBceuxl82jShVp4ZFdHzv1s4sGyDdXby99wQ0MahxOToI+Kq/e1+t15mEZh2eOHrvl6RQxVNl9UBz+B/u1Yp/CvC2CnVfP8oXMP1vipL0=;
Received: by smtp57.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1dZcoD-000592-BU; Mon, 24 Jul 2017 15:50:01 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
 <CA+P7+xrpKTuBTueyGGVz4doWMnbGQo+2qj2wbpPvXBaW-iDV2w@mail.gmail.com>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <47a657a1-422d-5947-87bb-8e5db5b8689b@list.ru>
Date:   Mon, 24 Jul 2017 15:50:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrpKTuBTueyGGVz4doWMnbGQo+2qj2wbpPvXBaW-iDV2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-7FA49CB5: 0D63561A33F958A5F8D79D508DCAD04139E793E6D464D5A8AFC68B5D6BC2C1F1725E5C173C3A84C311BA4339981C382AC088EE10F3B0FD3A2629B07FD02F83A6C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FD29CFF114C3378C93B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C42450394781F4929A2805C5E7C04B9B3163DCE99E73093D3FC1653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5F12E8A1378CD1C43C87F4A2B1C62CE1FE34B6126EFAA27AD462275124DF8B9C923A316D17DDAC330E5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005032BDE78ED4CC6ECABEA9E0FB38ABB6C409AAA9413CE14DFCA523AD9247EC42BBD9A213A94BF4775DDBB79867CC2C1EC5DD9ADBE8243F6ED0252A3EF2865ED2F733E9BFD465368085FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

24.07.2017 07:02, Jacob Keller пишет:
> generally, I'd suggest using "git describe" to output a version based
> on tag, and as part of your build system set that in some sort of
> --version output of some kind.
I am not sure I understand that suggestion.
I can use 'git describe' (and that seems to be
what linux kernel does too), but I don't see
how can I get away without a temporary file,
maually comparing current 'git describe' with
the one stored, and updating that file in case
of a mismatch.
Could you please clarify? Maybe I am missing
some makefile trick which you assume I am
aware about. :)
