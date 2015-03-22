From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 23:07:55 +0100
Message-ID: <550F3D3B.7080104@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de> <1427048921-28677-4-git-send-email-koosha@posteo.de> <550F1E9F.40801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZo39-0002SC-Gt
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 23:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbCVWIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 18:08:48 -0400
Received: from mx02.posteo.de ([89.146.194.165]:51670 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbCVWIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 18:08:46 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 726E725ACC56;
	Sun, 22 Mar 2015 23:08:45 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l9CfP2XmVz5vN9;
	Sun, 22 Mar 2015 23:08:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <550F1E9F.40801@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266098>



On 03/22/2015 08:57 PM, Torsten B=F6gershausen wrote:
> On 22.03.15 19:28, Koosha Khajehmoogahi wrote:
>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>> ---
>>  t/t4202-log.sh | 141 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 141 insertions(+)
>>
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 5f2b290..ab6f371 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>>  * initial
>>  EOF
>> =20
>> +cat > only_merges <<EOF
>=20
> - please no space after the ">"
> - please add the && at the end of the line:
> cat >only_merges <<EOF &&
> (And the same further down)
>=20
>> +test_expect_success 'log with config log.merges=3Dshow' '
>> +	git config log.merges show &&
> Indent with TAB is good
>> +    git log --pretty=3Dtformat:%s >actual &&
> but indent with 4 spaces not ideal, please use a TAB as well.
>> +	test_cmp both_commits_merges actual &&
>> +    git config --unset log.merges
> Do we need the unset here?
> The log.merges is nicely set up before each test case, so can we drop=
 the unset lines ?
> (Or do I miss something ?)
>=20

Good point; we can drop only those unset lines whose next test sets the=
 log.merges.
However, if the next test does not set it, we must unset it as it affec=
ts the
default behavior of git-log.

--=20
Koosha
