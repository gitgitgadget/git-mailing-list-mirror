From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] crlf: Add test showing double warning on commit
Date: Sun, 15 May 2016 08:46:32 +0200
Message-ID: <5e47eb63-41b3-31d0-7781-04d4e6eeb4b8@web.de>
References: <20160514111755.GG2345@dinwoodie.org>
 <baea5604-e786-5773-aa68-f311efb23752@web.de>
 <xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:46:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ppC-0002Ad-KR
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcEOGql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:46:41 -0400
Received: from mout.web.de ([212.227.15.4]:52651 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbcEOGqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:46:40 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MY6lc-1b6JvV44lU-00UuGh; Sun, 15 May 2016 08:46:34
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:dciLZYLeohx4bG5dSJibduf8SZFqvyet6UfED7Z822JuyKEVVjB
 Tr9k1tCAFVbhLD4SOu0hq6+TcDP/ENdODV5jLgEQGT22JbTNAahXAc8j/2GR3/kkUvQ64SE
 ZoZxFCIuk/RHUVUbGKERKcMYxx/9g0FJQ9t04mx/2GUnOwIFPsyJ//0favqR5Q1TJDE/HRl
 +8JaS+AUT+x9n700HOGTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oZcEeVsS4Bw=:4ZdANPxsz/LZ3R3PuUP/EK
 JT50M0iSTH8UTsRCE9uVDM3OgEZOmIecdPZkh1st5dS8WygwXY2e9n2FyyaoU1y4H8conZ/UJ
 BEYzpddIVNgf8lPFFvLGTth1Xf7PPTbFPYMsxwXrSF/tNxQIJBDWw0bxX+RQOcpKjk1qlkrlg
 9qZvG9uH7Ds4FM2gAAh3gGmbBWT91i4RhYdJWV2HUGVIa15YqODD8rOrEzhkK11DTpS7Ynaj/
 ec5jwhe8FUmTHokujTisgTrNjwScBb/2QhJCsxnC3J+TDskXzwqhqncoDV2CKe/8+doEZAgQN
 Q2uHlPlQ2rIsp/D3qzbgocT6Tjmnnhsy/mExkOJvsjAvOlnR7p8b7g+ooIIeZNfdYH6cLwRlF
 V3CAQ7/MkuLPUogv9J1hEZf1WtZvNSSDZT2a1l3REH36vpdvOukmm+4HnLs12fd6d2pIFce2J
 B0rkgEs8gdmgNls+J02sZr5+L/ET1J+cwSdOEUnOFO9XjoLNXJvLb6P7/mt5mrZyqrdPbqHOK
 vj5UnJ3yXJdVYvk+jPSDxJUqnA+kxSQg9YibZaL+CJGNIkfhGgAAhg1bzDWxKTG5UWqCWmZjn
 V51aYus9sKFu4NuxbH0lDHCckuzFslGe0skwnlDsc2rTf+WgrwFtHzVvRql5Q/rpnzJC00J0p
 0u06L8/suEG2LFGo39bYn1i26glEqzsmRKvLZioSi7MK7oYgiTghYf0MHlnucKv11MydyO5p/
 RtBX5YFT47OJSWAwbB5QZzyCxaxYdYoBj6e2FRi+7KBOzClcJLUzsMXrR1ou02Kx4zKI5LwH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294644>

On 14.05.16 20:45, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Do we need to run diff_populate_filespec() twice when src=3D=3Ddst ?
>=20
> Of course we do.
>=20
> src and dst may have the same path, but are coming from different
> places (src may be an indexed blob while dst may be a file in the
> working tree).
>=20
>> If yes, we may need to introduce a flag besides
>> #define CHECK_SIZE_ONLY 1
>> #define CHECK_BINARY    2
>> to suppress the conversion warning ??
>=20
> I do not think that belongs to diff_populate_filespec() at all.

Just to remind myself:
sha1_file.c:
The warning should probably triggered from here, depending on the flags=
 ?

int index_fd(unsigned char *sha1, int fd, struct stat *st,
	     enum object_type type, const char *path, unsigned flags)
