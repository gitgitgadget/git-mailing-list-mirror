From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 17:22:49 -0400
Message-ID: <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9526_4445504.1213132969808"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6BJk-0000xT-4Z
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 23:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbYFJVWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755021AbYFJVWw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 17:22:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:46657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbYFJVWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 17:22:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1918895fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=rTDqiZpBiZ2xNB672Tm7B4BNyYlLuXi6pqAAKTiQJzA=;
        b=Alg66BLOnlO42w8tYysIWJ+onlDw/iK3g32C/rYghyFVpvVQXI1bgU2OFuze7dWOMG
         zOYXJHVHtPPU1USPBJt0kzmO3BEyRum5m+W77Ky/ZczFn7vT4K9BJb3lx6XAdOZ/gZzj
         3jKaOu/tnFxyixxYVHNraxBqXSOqicsYDz1bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=TsorWmfw1gOR2pzGEY+VukCicnK/Hx3MoL82L3Qf5h+OA1wAt/Ei8MoxhaRsFBElak
         xmkmZkA/T53Ag1hhwNrxuM+A+crBK2JNH5ttkq41Bpay0E2aRpRUx17bHgRUUd+zLxsR
         Y+ao6Gd1C1VtYswVI67xVlm5rFYcez2IdD6MQ=
Received: by 10.86.80.17 with SMTP id d17mr6294113fgb.24.1213132969778;
        Tue, 10 Jun 2008 14:22:49 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 14:22:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84549>

------=_Part_9526_4445504.1213132969808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Jun 10, 2008 at 17:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> No, almost all the interest is basically in how the whole repo ties
> together. The individual corrupt files may be interesting, though, ie from
> your original report:
>
>    error: 320bd6e82267b71dd2ca7043ea3f61dbbca16109: object corrupt or missing
>    error: 4d0be2816d5eea5ae2b40990235e2225c1715927: object corrupt or missing
>
> then *if* you have the files
>
>        .git/objects/32/0bd6e82267b71dd2ca7043ea3f61dbbca16109
>        .git/objects/4d/0be2816d5eea5ae2b40990235e2225c1715927
>
> then those two files are interesting in themselves (most likely they are
> not there at all, or are zero-sized, but if you have them, please post
> them).

They are attached, and they are not zero-sized.

> And as this was a result of a real filesystem crash, it *is* possible that
> you have something in the /lost+found directory for that filesystem. If
> so, those missing files may be found there.

I checked; no such luck.

-- 
                              Denis

------=_Part_9526_4445504.1213132969808
Content-Type: application/octet-stream;
 name=0bd6e82267b71dd2ca7043ea3f61dbbca16109
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhazz8kz0
Content-Disposition: attachment;
 filename=0bd6e82267b71dd2ca7043ea3f61dbbca16109

ZGVuYnVlbkBkb3JvdGh5LmxvY2FsLjQ2MwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACi
BO9qfScgBcthyWfAEo0fBUBF/AX3nwGyIS1RJcBM504rimp19EMht6qYMXOLDoPhlFlZqFdwSUct
Zhkq+YUyrmCyzmwjLmctLlZRC7lTFoIX7Qc3MCdc0U+se615TNf+Hffw2K86FNJsPaRxntfgO4i/
NXWlSutItXSQSxH/txbJ7QFZNb+aTGsD8cXTRKU8nIMbl5objNAcEL6AFMTin6wnLa81kOJyJmTY
Og/MP72AV31LJkrd5pixQpsG49+asXWpiabeJSiIan0D7qNaa8gvB3a8YiLMriKZlpDUKm4q6xdB
/G50cvUSQhUC1762xLskPyp9a+mBz3lwrMWA2yoyK1mKllrd8KQytJTpjEJq4vdhmZWHRTSu85xr
5BuOkwxSmuRBfHV+dErcF/Ji963FZBlBv0es8Llq2NzkrEoywPQ/F/iwpApIT1F8i4zVr8HsPZ9y
AC3hB98VE1P+gu+foKsAEDnXYXETFjyxxod0HI/g/Rjeb5aeJbnF3ohZrlKaTmQJFw+PM/XRb+dX
loCTxcrTY82GUiqD+NfRBTk67+cqOOf3JeRlHuKj5f7JjunRQ/GRy/DGgPe/Oz4+bhl+ujr//f1x
P0FTakjNXOM+EEKaZW0A2FfMlIcijfZ2X7959Qr2gMvRGAkNF7hbjXo8CH10JiCWCmYYxMkdlRBo
91RW9zsvfRycsw/8U79cYP8M4lGmEJVyqlneSe4Yms3nVhgUBH5QDNgY8qMVrEuoOXgVdnMceKt9
Sc5clrXytOCdno3WPLe7fJYlFIoBY9UzFUWzAzgTzbTgBkQ1VQpDpNoSXYTbVEgOoUCvDdeGjjOm
OfiRSqhn0aHkgs551fdYFsgfNhDtbG5bJa2R8Z+zWqR8yW9RoBeGnOKHDWy2yr6Jdo/0zp+cAW1w
oyWtj3mTLhDrKNepoyBaXVFlrbdmMHTGzmxfJNBD2IyikqtS8u9YXv7yOQJnOEMST02TtSimqksa
BLnGd1aOHoP3iw+bSYkepGdQxExz9O/yMQq4/9QllLpMdpmDt11f2bePLW5Sb6cKRfZBjFdc2Iht
DUDcyKXcVau8A001hCpUy+u7qwW9KDBwAZXLSytTr2mMZCZLld3IgnjsR/3zIUBSUTmi7+1zI3Kb
kzAHfOSQIrjuF2vuPtawj+mZVnBHgjSZiZ2JKCjW9H4KnfHqBNJtwkx1+Lnm+iHa+/nta6jtPIMG
LOu75Lql6MR3r+21z4VZktSek5WApQkKYMP7Txvxh1UmzB+idGytmxbsLsrggARbBSz3clh2XWH6
2HVZ+WfHiy4rhbJsJVgqKbk1L5Z8FqEQt4tSGfBLrKgaqK4WM/tt9bu1VCN8n+BTpdLqzln9BJ7J
Ja9ge7hdErJvIcvZX3D0sz74q31eFsHXEtax3YkDTx4b68pOgZokUygzB0uVRirumgNHAsUb150y
3b3wwbXl4OQPUp2DUxuUvvp1joWyduvehvvm404q7PGJ6QcHytFi3ADjKbsC3g0gGT/KqDEdzNt6
mMG0sCzE4sz2BSeXlwCRKk7gFA5NB3/wjl68wCMXSgC35qCFGrhjiNelOT+44eOK9bkUOKthta7t
MSGIPzTDLn6OvWe4Db3FtObhaSAuybHAsDVFQ23l/hwgb2SyhL5n7MBvlnwJ+s2ahQar5oD0Mxe3
ouSpYFgLQ1Zuhl1rWAew7YRGpEe9ecGuedhuj1VBKIpFxyVPBJMH425PoiGK94228F2M1Z7Ckte7
Oa7nZF1/Da6G1fNaZdUIJskUlC6ds3DTMSFwIsRPy7YgpJsznYz/MF62G2ZdOGiVWaHa1OxFeHrb
ZMkM3eTTWuARyG0705sGo8H1ML+GHufi93hS6lngV55AyUBGY98qdDBbaHuWbOGxkMU/OKhds6vt
eWISHteTXFRR0DQlQQbsmraNuqBPxVX6DZtnsEKPsivcutZZm23zlX3bmPOf5qzVSMGtD5tM0JV2
fQrcgqFoPy5mUphsZ1yyAu4YLh3bNVJs20baeTDzSdvwuixwYq00K6Agx5oey7knhwmuQ4JrjdCl
aGlmbUhb3jCtKkuJwVrG9n3Qns9lle4Z2XVXA/j/AzaU/xVDrLMHj2gBsJo+Q1B0KT4FZRsxALhv
3NohYE6Xy1gKFa8V1tvJWWixbEjx3xD2vxLQFokH/wfRKcIN
------=_Part_9526_4445504.1213132969808
Content-Type: application/octet-stream;
 name=0be2816d5eea5ae2b40990235e2225c1715927
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhb014sb1
Content-Disposition: attachment;
 filename=0be2816d5eea5ae2b40990235e2225c1715927

ZGVuYnVlbkBkb3JvdGh5LmxvY2FsLjQ2MwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABj
UdXgXZ3vRKRiJcz5BFyi8ZMIxIg/4fkcKBvTGpcEnOkyBUCIibqFwQPWCb9IoON9g8o+MT3eWlTr
TKOejrrA6gsgFYE5EqyqHcON9OxIkf7eiOzmkKwTo2bzxoDj8TxTOY+XYN9ac4OuW9IovYDYZOk/
kWJYUJ9UA7FfMiHjjlYYf3YBXdumzJS6KTGUY5cf0l9D23E90xSYcZwBVPcCz0mjNQTeoWv3dbdp
R2TzGqLdcmNd/onSN5PTq6fgw+DRrtsJpz2RH5S+cfJgNS05bmUwZLA60LAWvrTW6ppn1tBa5gsK
Mcvv4rqoj6pk2pQl16g3nmYFxLrkUXp1fnxG/BfyZP+l42TIYLuKNT1XQc11yWxWAKf/usCXwVLQ
uRB+R1ng7C2fcyAt44ffVTNT/4z9j1irABI513F1HVc8c8aHPJVOoH8K/bvRs6x03BuxKFVO85ms
4aelx5v6+NfzKyfAY3F4tlgzSMpllP4yuSDH59u1Cs75XQ0Ji8f46rR/dG16fF994DK+NuD9b05O
TjqFH6/Of3t7sl2gqTXkLK4xQcaQf1gXAK6LmfpI5MnB/osfnz2D5Hg5maKgsfOroAJ2pg0Pwq1x
ISCWKmYYxMktlRBod1Tau72nbRycs3f843ZcYP8C4lHmEJVyrlnZy3oYmuFzB8bZGqzdOrxvrvt1
DZsxt3HBzA1uTbhxg7e6TvLadzo8YWWEnL2ebHhuf/qiyCjsksYtz1iKZgdyZpppwQ1INzaHJkrt
hK5gzYXkEAr0veHa0GnBNAc/UhltVfQk+aDzXvU97pfyhx1Ce2n/QaQNKv5j0YicD/wWAT0x5Aw/
7FDzIPZdsreg9/7kbOaDG15Xfbvcq1dgQLT6asNZb8Ng6Iy90e3uSY9gM0pqrmrJv2Nl/fOnBJzh
NYp4bJpsRDVXfdEA5D32ORxbDN6zTR9QyWr0IL2A3X1eon/Xn5OA+09TQw3IZF85eNv7K9f7uckh
9fbKM1QfpfiLEwNsZwDiW9ut8gZWqiFUoYzc3F0d6VWFgQusXF46TFtNYyQzRa7cRhal07a1fTwE
SC6sF/rWvQfIXU5Ch/nAIUVwvR3W0n9sYB/TC63giQJpthB7M1FRLHbbIXTB7Smk24wZe/Sp4fo+
OXj+8gUUPa2CQJbPN+87iR6+7/aOvTXvZ02rySFgeYYAXHj/4SL+yBbC/FvUXq1z04rdJgWcHGCr
yLKmxeHU9cGsckzP5fqq2neviw4XhVgeFFgrKbkzLxZ+jqEYt4taGfBLrKgCVVerkdtt9ZuzVAC/
Dfhcqdzeequfwju55Ba2h5sByG0TWcn+hDOR88Ff3PsQQltLuHTjS3EsyXfWlb0CNcvmeIwaVBq5
uA2leAbFG9e+QEfzj31HG1wPnCjaE0bvRNEFZVv9OpdyWPt1b9C++yCQC3euYPrek3K8agdiWsm+
gPcNgA+k7FYUTAfjMCE8eJAZglgdZr7g2PEUKFLVKRxP4TTenkiTJ0/wLIII4IHWDLj8MaRdSzg/
/FUGwVkNa3TjjglR+i40+/x59YG8B9hbDQsvjyNxgGPFYVhykLXx/Bok71QyYL9V7ckPU76E/TBn
tYb1CIf0sxQ3oua5YFjMQVYOzb41sJZog9uL+rw3r9SFl4ftsQ6EIiw6rXkmmDyc9g7rQaZ77rRF
e7xfP2wPvN6P8ZcxzvU36Aq6vq5V1o1gskJB6dI7C4e7BAInQvw0tAUh/ZzpMf5F+zxsmE1wcIfk
QHWpuYXw+DuPgRn6yaezwGcod/d8rWkwGvzl3jdw+bf6e8A/3W3gYEI78xRKBjKZtndonmZH7Zfr
WGFpXzzV/haouwzEJDxtZqWwSRRu6wADXid2N1jRtiWuyw9qvoIVtix2TVvfOhujXb5yvcGcXzVn
uTtjuGmCO1t/WYH7MFTuJ9VCClPsTWtWwRNjpmfAAOXxO/Fj92K89RpigWOr1ayCqhwLe6zpHh0r
OA8FblwTDkImjNqRu1rr9Jbcz97OPN3O/gXlUCcwONtaRd4/LRfuNjSCK3q8c/2/WGNTPbjFEPTO
DWPzYnbA+PYkhfuiq5Y6JYNE7Kl2ZMFre4UbuKPDgpZC7evAthL83NW0McWbendxDxck6eh/Y/B8
Lw==
------=_Part_9526_4445504.1213132969808--
