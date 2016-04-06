From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v1] correct blame for files commited with CRLF
Date: Wed, 6 Apr 2016 06:17:49 +0200
Message-ID: <57048DED.9000904@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1459884234-13026-1-git-send-email-tboegi@web.de>
 <xmqqegaj220t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Apr 06 06:18:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aneuv-0004rc-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 06:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcDFER7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 00:17:59 -0400
Received: from mout.web.de ([212.227.15.3]:60376 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbcDFER7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 00:17:59 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LoHfd-1bTbJ13aH3-00gDlr; Wed, 06 Apr 2016 06:17:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqqegaj220t.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:c+6xnMGGNo/PqDiBxwDNuzd2Ngj4GnJtp4tt0PShYU5b1TxxjSN
 4HLCb8GpubhsmKyX+nEQrC61YIMlEOlhei+fKGJv3HFCEdri4bPb+SjvnID0PAAHfXqCynw
 RIksyjg+Yy8byrN40UR2KaK3NcNs9NliF2sFTqUPKHrK1Mbwr2tGOjNqe9wcb2jNSUjugcK
 qr8GoyWdR9dmNaIMk2NJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bL+Hkaa7V7Q=:jgj7EdmpSQH4lo29/3z07d
 Y/5utoOz6LDmwA5fr52tiGDcAAPvNqNaZ3gf1frbRox7/5ELNLwvJfvLuSXpeU0NSe4bWyAKB
 zxpJLi9fEXPSEUu2MpkmplKX1grGo6W6UQ4XpeGX1Tj4TLSkrA/DFAfN+65CxBREZ/dLoNz4f
 I3mH3vvyosZEMSRQ7ORoJmdMb8jZFSSGuMNCI0a0wENoj1XisP2duYrR3wfc/nWJGyLRi+v+Y
 WS0fSD7/51eaCN8j7hitWXNf+QSz3PeUKTpz2inxoSO6qsV3iOu9+CtEjAQrmTv5Rf+2/KvL8
 A/Nh3eEv2M76s04pwBib8Sqy5g7UhcYgTICBy6IdCb8OxeAPGiKiRlIaqKVqfKNoxfqAWInpo
 JN2TkRhGzQJAYRYKCBwDIGiRrsuLSi6+5v+n1VU3COOSV72Z7FaEbOCId71izXEDZ2LJXMEY1
 novCX9MrSoUHClrPkSIV1NeEniKdt37JeF35f5rUxrVONX5muG/rsWNa61kp2yhF1QkWwBWDP
 tDqLSwxMtrtnR/CotkFxx2P2elAnMm8x7Wlzro34nMq2Bm1eoS93dVBsP4FNLhrDKRtafpNep
 /ymeepSVg75mux4xGdoNj7v1LLErYJgBsQ4CocUuzh+qoLiEaAFRy+f50/HNRcB0NFcdy1cAx
 YcaMmjy9vZmDrIHCtpQIs8hJZWUzSOSioIx75afFLU3jowCYuV2lmVzKP72Tl5KYvQ9WKvjf7
 Esq7QtwoirJKAZLmHS4yQ7OvTXmI/R3DL27roVpU7ih1gajmH1s/FofjRKFq+im/d0+3lCDp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290819>

On 05.04.16 23:12, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
>> +	git config core.autocrlf true &&
>> +	mv crlfinrepo tmp &&
>> +	git checkout crlfinrepo &&
>> +	rm tmp &&
> 
> Why not just "rm -f crlfinrepo" and "git checkout crlfinrepo"?
The intention was to get a new inode number, which marks the file
in the working tree as modified, regardless of mtime.
