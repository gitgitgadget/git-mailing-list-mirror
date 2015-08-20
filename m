From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Thu, 20 Aug 2015 21:02:29 +0200
Message-ID: <55D62445.5030402@web.de>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com>
 <1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
 <55D55EC9.6050002@web.de> <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 21:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSV6u-0007Op-HR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 21:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbHTTCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 15:02:44 -0400
Received: from mout.web.de ([212.227.17.11]:64711 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbbHTTCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 15:02:43 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MA5v3-1ZdkaU0NS5-00BK2r; Thu, 20 Aug 2015 21:02:39
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
X-Provags-ID: V03:K0:AAy1SGiW0RIUuIhh2nIsyH6WKr98guqrYisN4x7RrRmzsGlra34
 dw9JUwXz8h1bFDr/Xd3a0f07gGFF0VDa2xXY1ggaqW4El0jrenptlQQpntuWVowWuJkhZmC
 ByKW1m0UKgnskV2pA34q0tzxruw7E/9F2cflh+9lJ8A1kr01H4d1CioNpCT7nYPu0qLKlXa
 xJvu5jjlORQ/uIzQo35oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zqM18I5nuEM=:wMhqUmkTKB/oTDDekZkRmN
 tFEyqO70eGASch0v6e9ztUvn8QyPpL5nm9h1L1Y0ks7KCQsxNzCdKkENRg3jbKllGsWCYp2nk
 132eyMd8y/HyFU5In8YqPc0vXw1mxwb5c4bcMO96X0id9/1TwE7d4TiqAYlr2AyvPA+hZNStm
 gejWXfup9sOva/Ya7V5nzdz5dowEwhQWUIgNTkCgT6npasunWGeiYcs3QbaVUScMaIJtZiUTb
 xKPaJQOk/kur4DgU56ynbX0o0rKyi+4LEVu38XLEC65sBOPgoE9Vm9ZkP8Yg1W6426BStKqbO
 xccAE2KvEGH2v2hBM2lIO9wL807vfUbzFpaQgl9oq3AMp1mZReo0Q1zU6Sesdy7Te+FY5uR4J
 tqttTnDbnj0SCKWNFhaKIEanPbToRHoYDi3sXYo7G6OtixC3GEJKB9k/qNcazsg6yVyGfSWaJ
 gSkEjvIkWv8Yj/ZKJvnjiQ30YZypJrxS+pqka06TShUd6+7WTr3AVTKsTMy3ZoyaOWofrYzEc
 ounagqlcQmnGetRUbQ/ReH0EkCHPf15qLWk1hNV98E9Z9KJdxkpEk1taUcsytdhJ/yFU50ISq
 hF7vwxNZFOMkG4zFGcIE+boh2ZYQGrrmWhP4IwPJqVKwSLdppDeHqXvZigAvV2oDkte8+ir9t
 628LgnSv+MXsiJVuWncpWydqQCNf/N2uMAhOekeUMgVBI1GFZX6Ws0JpUZETS3+yrDwpqq8XY
 0sZBwptoSZCW/WQTeeIzjJ9+oU1eD9n5YocGug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276261>

On 2015-08-20 09.16, Lars Schneider wrote:
> Thanks for your feedback! See my answers below.
>> Identify path names that are different with respect to case sensitiv=
ity.
> Agreed!
>=20
>>
>>
>>> If there are any then run `p4 dirs` to build up a dictionary
>>> containing the "correct" cases for each path. It looks like P4
>>> interprets "correct" here as the existing path of the first file in=
 a
>>> directory. The path dictionary is used later on to fix all paths.
>>>
>>> This is only applied if the parameter "--fix-paths" is passed to th=
e
>>> git-p4 clone command.
>> The "fix-path" doesn't tell a user what exactly is fixed.
>> Something like "fix-path-case" may be more self-explaining,
>> but I would simply use "--ignore-case", which is more in line
>> with Git. (But this is debatable)
> I agree but =93=97ignore-case=94 seems a bit broad to me. How about =93=
=97ignore-path-case=94? Because it is really only about paths case, not=
 filename case.
OK, better.


>>> -    def update_client_spec_path_cache(self, files):
>>> +    def update_client_spec_path_cache(self, files, fixPathCase =3D=
 None):
If you want, you can change the name of the parameter into ignorePathCa=
se,
but I'm not sure...



> Can you try to rephrase your comment? I don=92t get it. My =93cd comm=
and=94 is already in parenthesis (=3D=3D subshell), no?
I may have commented on the wrong TC :-(

This is the one:
+test_expect_success 'Create a repo with path case variations' '
+	client_view "//depot/... //client/..." &&
+	cd "$cli" &&
+
+	mkdir -p One/two &&
+	[snip]
+'

which should be like this:
+test_expect_success 'Create a repo with path case variations' '
+ client_view "//depot/... //client/..." &&
+ (
+	cd "$cli" &&
+	mkdir -p One/two &&
+ 	[snip]
+ )
+'
