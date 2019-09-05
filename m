Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5A01F461
	for <e@80x24.org>; Thu,  5 Sep 2019 23:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfIEXLH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 19:11:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:59285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfIEXLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 19:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567725048;
        bh=egtYld+QXNCjzcrMKuh4Ld1ndW93pkweuf7aK/F2qTg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=NEKv8768x7IN9MCUGoCS+mBDstC05a1nI2MOX09MLFo4MmVrDsP5JlV9We/LogywI
         SfADrLPsQEwxS41opPBiQUMskuDhISkwoZ8n57uQT8n02RNkGi2Ntj3gQRvHGSZlaM
         ZJGgMEjmrHz4Qz6TxZGb7IJo+JPcxCPyl2ENECHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.48] ([88.70.128.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1iSAQN0pON-00nNdS; Fri, 06
 Sep 2019 01:10:48 +0200
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <20190905224859.GA28660@sigill.intra.peff.net>
 <963e5249-82ca-8961-917a-f45c20b1affe@gmx.net>
 <20190905225802.GA19526@sigill.intra.peff.net>
From:   Stephan Beyer <s-beyer@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=s-beyer@gmx.net; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUVFOQkZJN0NUOEJJQUNX
 RlhtNmdSM1BPMkJoaDZXZ1Bvd1FNZEZWcHc4cDlybjE3d0k0K3N3TWVxSmxrSklnClBETlFi
 UXRPcGRGeUJYVzY4cHVDMXI1NjlNZnNhSldXYkluZGh3NVpwdTJ2djdjVXlOajlrUXR1dG10
 Zk1TcWYKdXRSZVAxZDNINmhzOWJSSGJvWkVqeXZqc0VTV0xYM3FFak9uRTYyVmNHMUpnNS9t
 dlFkOFRIZ3pwdDFlS0tSSAp3Vm1oY3JDRTV6a1l1YzNoZzdXdk5xNm96Vm9DbUpsYU9Qb3Zz
 NWw4UThUaHc1elQzL2hnY2QyeEFlODRIUEtJCkFBajVsSjZRU0l3bWYxcWROSVRvZCtLUGdl
 YnYwL3pBZ21vYUFRSW1LamdmelFMZk56WHI1TDJoNHNsaElPU0sKR0EzWnl2SXFqRGRnNmM1
 bFVWeFRKNDRaQkRFLzMvZEtTVG0zVW5MZjJDOTI2SGZUZGQ2ZHQ1T08yLzd5b3YxdApjWWc3
 K0t2VzV2ZWJMS0drbHhjRjhqdFMvSE9zOWxjQkJZeEg4WC9YL1N5YWc3QzIxckhGWE13aFZF
 QTlycmZVCkNFaFYyOXgwUGU5THFwRTd4ZGpIK1FXVlMrY1RHKzhHaGtGN0FuWUtpSXo4L29K
 VjQ1S2hTTjRrTXhPTFdZRSsKazJYd2VEOWhUTjQxMVJOd0FUS3ZJemlieElyV2xYVEVRbWJ3
 elMvUldDRXhTWTdSdHlUTVBIc1BZdDhzRmNzKwozVUFNZHNmdlF0cmtBdXZQY3BTYS9VS0FC
 SEF2a1VOeStvSkZqRmRUdEtrYy9oajk0UEVBQlJvbFlYUTFWRXFECjh2b1dKQ1lQUXlCUVl6
 RTZ0RzMxZFBnWFhzK25xdVhuSnBIRzJKS0lJWktXamJXcmVBSTFaQ2hCSThCOTFXbjIKdWpV
 VjVzdXRBbnk4VmtZY3BNQklwNVdVUVg1VDdxdE8wSUhsYmJ2RzVOZHllQ2tqMkI4Ly9LemZQ
 K0pqc3hqRwpHMzc1Uk9PdS81eC92eXhKZlp2SmUxcDRQRnNnVWF1MFRZbHExR2JuODFHSVMw
 MjU5NWtUSTdrVzdMcERMVG1xCnY2MEdYSWpKQWN1RFJQbWZyZktXSDhZNXk2VHVDMnZFVVpH
 TzVsR0dwV2NLM21HRGRpd1dCNlpYRmhJVGF3YUEKQWxWaHhCVUppZ2JQLyttaG00M1ozUzRC
 N1VqYVpsZGp6QjZuS3QzNzVQL28zYjU2NkdLaG5aVmh4S3ZvQXNoagorU3c4Vml5ZTlZb0ZC
 c3VSeTNndk92VW9MSGtic0JrS0ZncmM0RElXN1BHWVBOdmZVbW5VSXNFbFZYdlVsMWxjCjJG
 SWxYSnJhZDNzNlFMNW0rK0pJblZrWU5Mc2o0OVZpb2JMaUxBdk9Wd2ovN0JHQS9ralJEUXp0
 OGQrZzgrWVIKQnYwNHQ3Vkp3ZWU5SFp1cGFwUGdyb3JzL3hsL2NwSFVFcXEzSFdDSm5ucXpt
 MVJqbnpMZ2JwZVRjQjVBazFndgpKTDZmN05LMXYva0RucVl2a3B4K2YvUDJtNGhKdTVhTTE4
 ODJzWmc2NlF3WDFrREw5WklRbFladFFUOElmN1gvCmV5eGZVZG9WQUpEQThIcFM0NlEyTHp3
 WkVqZXFYYzkzTjNMSmxIZFQxcm1OZERDanhtd1BSUWllUW5TRTRRcmwKU05qWHducXl1M00z
 Vk43ajNNQ1hJMUdWNVUwQ3VvZVd1RGdpUnMzQ0ZqZTgxS25mL0RuYy9jL2RuNmpoeVR2aQpR
 a0NMY1hxUDY3Q0l1T2xVd3gzMU1iNWJpQ3IwL0R5YjVmVXBBQkVCQUFHMEgxTjBaWEJvWVc0
 Z1FtVjVaWElnClBITXRZbVY1WlhKQVoyMTRMbTVsZEQ2SkJHQUVFd0VDQUVvb0dtaDBkSEE2
 THk5d2EzRnpMbTVsZEM5K2MySmwKZVdWeUwyOXdaVzV3WjNBdmNHOXNhV041THdJYkF3SWVB
 UUlYZ0FVQ1Vqc1pYQVVMQ1FnSEF3VVZDZ2tJQ3dVVwpBZ01CQUFBS0NSQStEK3phekFwOE80
 LzlILzkyREltWFBiUkdSVFBjV2dOR0tKNHRBUWxWQm00eUZPQUtoTVlOCi9zcDRIME5FZlp2
 L2ZXMXZtV3FnNlZpbjRLNngxVmhkT205MVFCOE00UThtdzVtbWVneFhNZXdMZjJteUVHamYK
 WEt1STh2OTE3TGhkOFdvT1MydUhyOFZxVldWRGZKRzZXR3VoR3NxcTJtcnVhWk41ZzZMaDNO
 U2QybW9heDUxRAprYTYvam4yOW45KzluNWpHQzV2eDNnTHRuSnE5dmlNbk9OVGdEZVpUcUVL
 NmVxU1ZkMWIrNnp4TStRc0hzVFI0CklzcHNDcWgzbWxsTTdZL2Ntc0o1dWdsZHZURXhsem43
 VkloV1FBanowc2xvbFZHTlFSN2krcmNRK3BjRFJGS2EKOWJHU0xxR3lhdEUrdVlLWVJtdldJ
 bi9zT1FOU21MN2RXZzRiTW5wS0Njb0FBeHd6RFlQay94Sm1PSlU4QjFPQwpPMXo5b2pKZDha
 a0YwRTlVRmswOW42ajYyVDZZWEZaemo1dFRJUU5iNW5IUVRiRFBSZWZESXMxYTBycDBNNHN4
 CjRLZzJzZVVQZVFZVXBEV29YR3pYTHZ5ajRkMHlyWU9wUmpEb0ZJdE1oMCtndmhJd1Q0NGNv
 aHpUUW1vZEQzVHcKSUZZbDRKOWlrTFI4SmdvRzBHeEo4ZkpnN2tyenlnNS9MOWlMMDBvZjdZ
 ZVJuZktWTytyK05BUGk5Zld1Nm1ZRwpGaXZGQnRXYTh2Qzk4WHlWT2NUYXhvTzVSaC9WTUxm
 OUdFTG52VWdjSEpQZVgyK0FVbkxIcjBnZ3NIdFgvK2cxCkxIRVEwMFBQdUVjTkZSODNmZWlr
 L3FoMXVIQlhDSjIzYWJIaHVVR1Z0RXljeEY4ZWFZQ1VIYUh2VS9ldnlDSGUKeElRZWhKc2du
 NkkzWHJURTFzMWVDSXEwRS9kdDAyQXd2cHhDUFkxRXk3UkljM0ppTE1oNVh0elp2dGtsTFRy
 UAppREp6ekRXTll2V0RoRUJnWGM2alJteDk3VjdJZGZGbUI0K2pGR28yL1QxdlhMdElURmlO
 SGFTT20xdWFMM1dtCkI0OWk3UVFqZVVtQVd6UE1WNE52UjJWbnNiQmdHQ2Z0cHh4REcxdmh5
 U01TT2M3QUdXa2NtQnVKamxqcE1zVnMKSkVBaTdGVnBQUnBGcE9VdDdkcmNLSnd2aHZsV1dE
 eDhCQlhXcHNDN0pybElvRzJNZHpNNFRDa0o4Tk5wZUNCRgo1RXJmdHZDZzNvcjFFYVBHeGFk
 NUJsVUlUS0ZXM01ZbXhXbHo5cURHQ1E1Vm9jY3IrUkt4aGwycS9HVnhKTVRECi9JWHZ0VGNt
 OTFQWXp2ZW44Sy9KaUs1SjhNdVFpQ29RLzc5Y2VCYTM4NjZhN1dlUkMvdGlEZEtWcDBnamlS
 M1YKenhua0hYNU9Ud1ZLMkR6amZiTG11NC9LVVowUzNTNzkxdGRlbENRNzFhZk9DYUVRUmQw
 TVo5L0MvS1RxTEtuYwpGdFhEUDFnd2pzbTViSTJoK1JBTVdjbDh1TFI5ZjJ6ZFo4NG5NT211
 TUsxU2wxeXl4Qlo4aG9xVlZNeEJTcnZlClZHeHB5cm9PT0xOTitIdDhiMjkzdVY2NWZ6eUJy
 U0dTcGN6TUx2cTBYOTcxYmU5cnZGNlZaUUtDaEp3N25lV1IKWk1vQ3BiSnE0R0NNakhEdzlp
 Ymw0OWxrOUVWNytUelRiV0thVktvYzFyUmZCMzVyVUtMUWhPNGR2UlA2aFFNTwpwNUlzVHBM
 bWFXOERVUTZJSThJTTg5VEtTaDRQWStCSzZDR0MwKzF6clhPdTZDSW51UVFOQkZJN0NUOEJJ
 QURiCmtnOS9lVnVOeXdMR2RxVmpiV1NmOXdOV0ovWFBiZDY1MFlaRE5nUlNhNVE0NW1YZHhp
 WFdEL2pRRnhRcy9iRVIKU2hCTWdYOEVGMkVVUHpmRW9jY3B2MGMvZks0cGJwT0xseGVDcE04
 K3dZT3lSOWszRHNyZWtVa1FJaHlRcEZZVApZR0V3Zjg0TVBpT1pBSmVRYUtIVGRWMldZWjdl
 eDFqQXVRN1ZxOWZldUdBV1ZwUFAwN2hEa0JTQkVhbHZHZ2RPCmg1S3NJQVBybVBmRU5XM1ZD
 azhSVlNWdWIrUmRhZTdMMHBvU0VzSFhGRzlGR0ZRQlAzSGFUaFlOdk14MlR4R24KYnVQVy83
 am9TY0I2Y0tvZVkzY0ptRjdUOEtzR2dvaUcveTVjZWpNL3R1dmVJZ2VPUXZnUUQ4U0FKcCtt
 THBDMApqYk5UZGxsN1NET2ZXSXkwbm5OQ3ZFMGQ5ejhMbTZORDZvVEo0UCtURFpPbkpjbG1O
 Nkl5alNxT0E2ZHM3M0VkCjV0dlpiVll0VUJzN2QwY0NjOU1aNnBzZlJ1N1VnWVZpdE54VWND
 b2l3ZS9UOTc1NFl6a0I1SzZzeWZqL21OQjgKMDdNaXBRMTJuS3hMUXN5YjJuVlhmWnpIS1RZ
 RjJ1Z0t1MTNMM3k3ajZPYzdkTlY2QlVnS0pSaXRrUkFRN202cgplYldCVWJ4Q1VZRS9UbmxR
 cDlsNlhDVFNMV3FPNVI0R0JjRzJ1c091TEhDRU81dzdiVHBoSitGODgzKzZpYWM1CldpYVQ4
 bldZL2xTWGdvTEhwN1NTbk0xRU5BMlJSUmZYeUFrYUJ0YThIVGw3dkpDK2ptS251aHI1NUpZ
 d25NZzIKWXltOHVQNGlVLzcvMGlRa2Z6TmNPQk1JOURSZXJ0VjdEdHhBOHRtY1h0L1J3d2xM
 SkdIQUozTGc5dFNEYU9Nbwo3eUEydnZaVlkzcWlXRkJHeE41dVRBT2hHZHVPT2YwQ3VRd1JG
 b2ZuY1NkYjh5Y1BUSWVHTkxLcUo0Vk0wUHlICmNNcGtxUHpnc2FMTzZOT3NiZ1REcXZGU0N3
 VWcxdThWTUNJWWJXazd3eUg5Qnd5WVNNMGU3NURPcmJYSVFtSksKSWNWZlpEdmRqSVVaVGU1
 eXFpNWFMMkNJZkN4M0JKWTRFN21PZlBmT0Q0bmhUS1VONG9ZaXRVVmRWVlQwcEhtOApXclZM
 QWltTFRtUXVTT3RrRUJlRkN0eTRtWlpPdTU1Zkh2ZG1ZWTFVQXVLUHlNeExDaGJ0SXIxdDZE
 RTEwcUVZCktWR1RmUEpJc2dub3JxRTRiWGwzK2UzSjArWEtoeTdzbkNZNlZCQ2pNZkFMRDNu
 RDNXNktoc0JVeForWVZjMFMKVGlkSzB2ekF3Y0lJWWQxMDNMNEVkdXp4dGxLeG52QjdsMndG
 VUt5cW5DZGxsMnZrRXZUNkpSS0VOK0dLZ3cwOAozelExRzBYOEJKL3hNVDZsZXV2WGs2ckpX
 RHpBRk9iRndUT2dMSlR6R1VvYnUwK01xeEZMRUJPdmhtU3pkNHljCjRpbjMxY0t3Nnd5ODBp
 OEd3U0JSb2VqSSt1OWJqZGxIWXBENG1mdzdGRSsrQ1IrWXFadnJac2Foek8zUkx3WUsKVE1m
 cnByNUlhaWlDLzNFcmE3ZG1icytrdHFWR3Y0NTN1c0tzRnFvVDJpaXo4RGx0eHF6WXNTKy9h
 V3Q2N2JQRwo3TG5wdDl5alRLOHRnNE42dTFUdnl3dGMvejIvNUR2TjJBdlM1UG5LNkZaMU40
 V2pmTmd5NHhUL1F2QzJkb3VZCkNwZDRkakx2NU43UUhBdHY4WlNkQUJFQkFBR0pCRWdFR0FF
 Q0FESUZBbEk3Q1Q4b0dtaDBkSEE2THk5d2EzRnoKTG01bGRDOStjMkpsZVdWeUwyOXdaVzV3
 WjNBdmNHOXNhV041THdJYkRBQUtDUkErRCt6YXpBcDhPNDcwSC80bwpPWlZPQU5ROUw5SmpO
 LzU1RFArYUdoL3BoU1JHbmpWUWR5TXVEZzdYaFlEYkd5SGJESExoSlVCUEVMNU9PUG90CmRK
 Z3lZZFZsRTFoRktZRC9Mb0tiYWZDeUJDcE10VnNKTjhtRkxONWE0TjVnR05RUzNXUklaSG1i
 Y0YxaFA4cm0KSDdPWEtkNUVUb1VCS1FxTm1uZWc5WHJlTm5DWTZKUXFtWVhtS0RLazdWVFhN
 QUhQWVRmcjZuZjJzdS80bzNYVwp4aktSWHFGWDdsT1lRZEhZT1FyUzhMQU5qT0QreDBPelh4
 Q3ZhemJXdFpyZEl2MVV2NmNKWW1mZ2VwWk5HbS9TCi8xemdtV20ybjltNjYrNk9qSU4xWDdo
 dFNYQTlmcGtKbUIxcDZHeENEaTJkL3dtaUJuMmVJNXdFL21MOEQ2UEcKVEZGTGlOcTRXMUgv
 WXB5VkVaNUhWZTNjQzV5MnY4L1VPZWlOYWNVN1MvK1h6dnZpMDVPZWJxdUNBQTZ1SzlQTgpt
 Q24zZFI1K2RYWjRHdzY3QitTVEcrdWxlWnFSZ1NnTWpkN2tiNzlGMy9NczFKakgrMkl0NVVt
 enlsR0VTanpGCmpBZExBRjhPSzdQTGhzeHU2TFZrelZPTTIvRklIdGRsNmxmcVMzL1Y1b0p6
 cEozR2lQTERXOCtXTkxhemJBRHQKaXpFV2RKcXlaOEsxWFVMSHRoem93enFMUXNWWXBIWFpR
 VU8xb2kzYTVGTEcvckdOUlVGZXQrN0VzUlFNOGFDRgpRQ1FRbDY5RnhNYk41bUpabldGSWgz
 TDVmK1FSM0hUajlFZXVCTGVLWnZMSFJhWThpSVBpdVYxc25LMmdqSHl1Ckp2RjYvempaSDNN
 YzE4cXJlYzdOWStmZEk1QncwMVhyeWZwZVkwT2p4K3VHck5qdCtNS2NIL3FSeEJlWEl3WWoK
 UWJxNjZhSXhJWTNBR0xkWDhFNHVwd2V2SnRYT0xrK2dBTmk1c0tqeTdzV2NMTEROdE9YVXNr
 Y0tPT0k0M2huVwp0d1FMNFVLTmVVTUZ4MTdUYWVWZDVQYWZTYlRXRVRWODkwejI2RXpxZmhm
 N29ZSGtRSGs4TmtKakZSYTF2MWRsCmh6eTI0U01ESVBZQi9iVVZPN3c3NFNUU0g1b3hIRE0r
 cEI4YmZlOEFaU3hMWkhCdEFockZHTFk1NEE0YnNiM3YKKzJkd3d0a2RRNlJ4WDZuNVFpY29B
 bVpFZGRJNTFSd2lRdzRneWRTVG1iL2hhUDdCOVZyWlVOdW9aSXdWSGpldgpRZkV4Sm5aVUVE
 NEJCb3lPaDI4NzdJUEFDRFRwNVIwZTNnTDB2cE5aaHorYm5jZmQ4MlhzbnQ3T0tnM3dLTEds
 ClVzYjBJcXNTRmZ1MHFzejNJV2JvRmlaZk5yNGROcVFCeXJYUFFodXphWXlhUGExelhqazJM
 L3BKTGNOZjBzaEEKMkZiNGoxTjJ6b2NjMHlIWmp5ZWNSTUZBbyswWGU5MDkrRGRadXdqbmZ1
 SFhmYTZDckZsaGlpTlBtUHNJWG14bgpmTHVqWjVHZ3JxWTRVYXIzejNmNnZiNTVJM0srNTFu
 b3ZsNTdxYktuTHdGQWRRaFpHVjM3dDBpRkRsY01EcnZqCldGWVd3NzFQUUtaZmFuWkN6eWNR
 NFF1bi9GckR5d3NCckJxY0M1NmkrTHBWek11YzNYZmhpU0tHb2UrWXhFY2YKTmNuMWZIZGRy
 enpxaUVUQlhCQlNwSVJBUG14K0NCVUJWeXBRaXdBSG1lUTA0cC9icXYyTVNFTkpqeHhvam85
 QQpwUTcwK1I4SUV2dVhoMnJKVExlTQo9LzRnMwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBC
 TE9DSy0tLS0tCg==
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <6894a758-d4ee-92e8-1aab-fc44c9ddcdc3@gmx.net>
Date:   Fri, 6 Sep 2019 01:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190905225802.GA19526@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ld78oz192ScSplt1L9ofau8ZYOJDMVsjro0IVFFfFd54ZA2KAR
 cQlbmCNEbaT8MQOAkcRUtEHb2PeFoKtykgC8IBUxc+B1shV4l6iJ+RBEIxxxztDE6AdeyL0
 CAo/vy7meNqajII/wEwXn1lyAmkdkpUujILj2tH6404V1gHuG26293xMu+fFW6PKJFDWIK1
 pVYiPK3GAUWcvxH8dKFTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yPBR+kIiplc=:lXbnRpwfNqjdDFUoxQAwQb
 N60jKuuAX6JKvXScQPARlOUDT7AcXIt1AarkSinupOddk6p9fMXZRdTRuCrrSSJJ2Bb1nCRNq
 ODtz9/3cqPe1lLbJr/rx1EYELhN/cWuFfelBb8zD4CD9vE820Aqf7e7l6lqvsMOTIyP9koFfn
 IjOXwTgHvWMwrefIAlxwI0lOy7H2dS5JoZM3jzzRdsYElnHNGE+gRpa+uAI3Ma9OrBfCWK7D1
 m7I6aBGVpABISRT4W25UxCy2/essiIwVwexxhzKrPatpZIGRyaeTp3Hi42/6nBi5WA2EFkNxC
 y6uEou+j69EqPH/LGn3A7kH3CuQ7v3jXTX38QZ1uFLj/UdocnUECx0QE+ccluRjkIN7lrKPmM
 XO0lTecNnCo/EAE1jhqG2FT7e6N4/CT2mlRZ/hM856V6jNz3RFu4KdQjM3lql6kIR7NTFET/9
 qIqSuTAencrhdc2O08PX6Il6RZ894Bp2ut5WRr1NNbYrWdbjzJGRENSbNh5OaGMJqpwp3/pi2
 olx1y7/RYQmUwdHHeW9slehhRGzCHhMXPmTxupORrEnS6soDzMEcnejXeU7YVYVy25QR7PHwZ
 idlDC7F0eyvb9yQk4Oa0AoSNjbtJ6vusHoe5nB5jIzLq4cCkx3kAUOvpeJppGPF6RCaU71qK+
 ge3vIIn9Qps+HqmL6VhG4y5QSyzXL2+MKBQQPlz+wKq2RJox/XljdYsuXLGC5qnIvMCwF2H6X
 CFiv6mCid8nMGFw/kZa1Rc3dLc1dy27GCJgM+QxtJnEKLwIojQ+lbGDkdm35Z/lWmWhZ4E2SS
 wR+LeSvZGWkONtZG/O7FKn1XBeoo6gAbIQEpPedvu7W+bChbOC5IqlYcuDFJG4tdy+huHg4Ae
 fYzFlVneibtgte8lMcNLx26HT2QRB9xgWsLQPXrRI+lxKP5YuYqgyt5G7HaUgJtKGRyGqb1/W
 PV411Exn8P48p64lr26tLgYYpytuqwJFZfd8poBvT367afYmaGXedmsqAopX/9fAezrRAjGeH
 UpebWVGXS56J91ZkVLAdbik5nmINhWGCHmemHyJ5iZnQwgoJ2kBLCDqshl1lw1Dux97XMbUyx
 c7Ss8G1TT1SHzjOzo8VBnGk75XRU/e5PNwCv4fde9TtEgpDT81UuTCaOPM1lBAgOptFfjx+/b
 45fka83HBXU2hNNZebDe4suGi3vwMyNpcIc+PIAdpkg0qx1suRVfHEMV92KqARxbCmIeVesrq
 Kzs6VvQcR9Ux46y3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/19 12:58 AM, Jeff King wrote:
> On Fri, Sep 06, 2019 at 12:53:49AM +0200, Stephan Beyer wrote:
>
>> On 9/6/19 12:48 AM, Jeff King wrote:
>>> On Thu, Sep 05, 2019 at 10:24:59AM +0200, Stephan Beyer wrote:
>>>
>>>> Compiler heuristics for detection of potentially uninitialized variab=
les
>>>> may change between compiler versions and enabling link-time optimizat=
ion
>>>> may find new warnings.  Indeed, compiling with gcc 9.2.1 and enabled
>>>> link-time optimization feature resulted in a few hits that are fixed =
by
>>>> this patch in the most na=C3=AFve way.  This allows to compile git us=
ing the
>>>> DEVELOPER=3D1 switch (which sets -Werror) and using the -flto flag.
>>>
>>> Lots of discussion in this thread. Let's try to turn it into some
>>> patches. :)
>>
>> I thought the same and just sent my version of it. :D
>
> Yeah, I see that our mails crossed. :) I like some of my versions
> better, but I'm OK with either (or a mix-and-match).

I took a quick glance at yours. I also noticed the issue you address in
[PATCH 2/6], but I was unsure if this is the way to go (I'm only
occasionally reading on this list). I would prefer your patch series,
with maybe one exception...

The thing is: I had *exactly* the same commit like your [PATCH 6/6]
(except for the commit message and for the number), but I dropped it.
Why? Because I had the feeling (no particular instance though) that the
second locate_object_entry_hash() for each insertion *can* indeed take
"too much" time. Also, I was wondering, if the "found =3D 1" case should
be catched as a BUG("should not happen") or something.

I don't care much, though. The performance impact should probably be
checked carefully.

Stephan
