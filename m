From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Fri, 07 Sep 2012 00:30:53 +0200
Message-ID: <5049241D.10604@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu> <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu> <50471003.9010207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9kbK-0004Kx-3z
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab2IFWa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:30:58 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46943 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab2IFWa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:30:57 -0400
X-AuditID: 12074413-b7f786d0000008bb-b9-504924200583
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DE.95.02235.02429405; Thu,  6 Sep 2012 18:30:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MUrxT025007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:30:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <50471003.9010207@viscovery.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqKug4hlgMOWUiEXXlW4mi4beK8wW
	K3/WWKxf1MBq0T3lLaMDq8fOWXfZPS5eUvb4vEnO4+7/nUwBLFHcNkmJJWXBmel5+nYJ3Blr
	J19lKnihWvH7/AbWBsbtsl2MnBwSAiYSvx9uZoOwxSQu3FsPZHNxCAlcZpRoufyCHcI5xiTR
	/u45M0gVr4CmxP3LNxi7GDk4WARUJf6t5QMJswnoSizqaWYCsUUFQiRmXJ4MVS4ocXLmExYQ
	W0RAQ2L36V6wmcwCixklfs5sB0sIC/hKTL5/jhVi2TxGiWUfr4KdxAk09fOhh4wgNjOQ/aNp
	JRuELS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIz
	S/RSU0o3MUJCW3gH466TcocYBTgYlXh4p573CBBiTSwrrsw9xCjJwaQkyvtPyTNAiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkgjvxF9A5bwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalF
	MFkZDg4lCd5qZaChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBojS8GxitIigdo
	7wqQdt7igsRcoChE6ylGXY67H1fcZxRiycvPS5US550MUiQAUpRRmge3ApbIXjGKA30szLsJ
	pIoHmAThJr0CWsIEtETkGchzxSWJCCmpBsbIJXt4d1xNUj171unyk8S6/jVONuxcUoobslV+
	itR8PsL4YdWSWyX37jp6uO2MmO8/p2JiHf+yMoaT8ZvCe+ftY5h1JUgt7sOEcN3O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204929>

On 09/05/2012 10:40 AM, Johannes Sixt wrote:
> Am 9/4/2012 10:14, schrieb mhagger@alum.mit.edu:
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> These tests already pass, but make sure they don't break in the
>> future.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>
>> It would be great if somebody would check whether these tests pass on
>> Windows, and if not, give me a tip about how to fix them.
>>
>>  t/t0000-basic.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index d929578..3c75e97 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -468,6 +468,17 @@ test_expect_success 'real path works on absolute paths' '
>>  	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
>>  '
>>  
>> +test_expect_success 'real path removes extra slashes' '
>> +	nopath="hopefully-absent-path" &&
>> +	test "/" = "$(test-path-utils real_path "///")" &&
>> +	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&
> 
> Same here: test-path-utils operates on a DOS-style absolute path.

ACK.

> Furthermore, as Junio pointed out elsewhere, it is desirable that slashes
> (dir-separators) at the beginning are not collapsed if there are exactly
> two of them. Three or more can be collapsed to a single slash.

The empirical behavior of real_path() on Linux is (assuming "/tmp"
exists and "/foo" does not)

                         Before my changes       After my changes
real_path("/tmp")        /tmp                    /tmp
real_path("//tmp")       /tmp                    /tmp
real_path("/foo")        $(pwd)/foo              /foo
real_path("//foo")       /foo                    /foo

real_path("/tmp/bar")    /tmp/bar                /tmp/bar
real_path("//tmp/bar")   /tmp/bar                /tmp/bar
real_path("/foo/bar")    --dies--                --dies--
real_path("//foo/bar")   --dies--                --dies--

So I think that my changes makes things strictly better (albeit probably
not perfect).

real_path() relies on chdir() / getcwd() to canonicalize the path,
except for one case:

If the specified path is not itself a directory, then it strips off the
last component of the name, tries chdir() / getcwd() on the shortened
path, then pastes the last component on again.  The stripping off is
done by find_last_dir_sep(), which literally just looks for the last '/'
(or for Windows also '\') in the string.  Please note that the pasting
back is done using '/' as a separator.

So I think that the only problematic case is a path that only includes a
single group of slashes, like "//foo" or maybe "c:\\foo", and also is
not is_directory() [1].  What should be the algorithm for such cases,
and how should it depend on the platform?  (And does it really matter?
Top-level Linux paths are usually directories.  Are Windows-style
network shares also considered directories in the sense of is_directory()?)

I will make an easy improvement: not to remove *any* slashes when
stripping the last path component from the end of the path (letting
chdir() deal with them).  This results in the same results for Linux and
perhaps more hope under Windows:

On Linux: "//foo" -> (chdir("//"), "foo") -> ("/", "foo") -> "/foo"

On Windows: "//foo" -> (chdir("//"), "foo") -> (?, "foo") -> ?
(what is the result of chdir("//") then getcwd()?)

On Windows: "c:\foo" -> (chdir("c:\"), "foo") -> (?, "foo") -> ?
(what is the result of chdir("c:\") then getcwd()?)

>> +	# We need an existing top-level directory to use in the
>> +	# remaining tests.  Use the top-level ancestor of $(pwd):
>> +	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&
> 
> Same here: Account for the drive letter-colon.

ACK

>> +	test "$d" = "$(test-path-utils real_path "//$d///")" &&
>> +	test "$d/$nopath" = "$(test-path-utils real_path "//$d///$nopath")"
> 
> Since $d is a DOS-style path on Windows, //$d means something entirely
> different than $d. You should split the test in two: One test checks that
> slashes at the end or before $nopath are collapsed (this must work on
> Windows as well), and another test protected by POSIX prerequisite to
> check that slashes at the beginning are collapsed.

Done.

Thanks again for your help.

Michael

[1] If there is more than one group of slashes in the name, like
"//foo//bar" or "c:\\foo\\bar" then:

* All but the last groups of slashes are handled by
  chdir("//foo/")/getcwd() and presumably de-duplicated or not as
  appropriate

* The extras from the last group of slashes are trailing slashes in
  the string passed to chdir() and are therefore removed.

so everything should be OK.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
