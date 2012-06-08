From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Fri, 08 Jun 2012 10:04:25 +0200
Message-ID: <4FD1B209.702@ensimag.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr> <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr> <vpqobow8a9l.fsf@bauges.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScuBa-00016Y-39
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 10:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977Ab2FHIEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 04:04:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42867 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760459Ab2FHIEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 04:04:36 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q587te4K017229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 09:55:40 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5884NuG008328;
	Fri, 8 Jun 2012 10:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqobow8a9l.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 09:55:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q587te4K017229
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339746942.28751@uCwF6si1C4ymFbWlFFbREQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199468>



On 06/06/2012 22:18, Matthieu Moy wrote:
> Simon Cathebras<simon.cathebras@ensimag.imag.fr>  writes:
>
>> From: Charles Roussel<charles.roussel@ensimag.fr>
>>
>> Those scripts test the functions of git-remote-mediawiki.
>> t9360: test cases for git clone. Including tests of cloning just a c=
ategory, just a precise set of page and a classical use of clone on the=
 whole wiki.
> Avoid long lines in code and commit messages (80 columns max)
Understood, it will be corrected in the next patch.
>
>> In addition, this file provide now some fonction du manipulate secti=
ons on wiki.
> s/du/to/
>
>> t9361: test cases for git pull (add page, edit page, delete page) an=
d git push (add file, edit file, delete file).
> When commis messages start looking like an enumeration, it usually me=
ans
> that either you read the GNU recommandation for ChangeLogs too much, =
or
> that you should split your commit (not mandatory here I think, but sh=
ort
> patches are easier to review).
Do you mean that we should split the third patch into two patches ? For=
=20
instance::
     Patch 3/4: tests for git pull
     Patch 4/4: tests for git push
>
>> +# tests for git-remote-mediawiki
>> +
>> +test_description=3D'Test the Git Mediawiki remote helper: git clone=
'
> Why do you need a comment if you have the test_description right belo=
w?
Deleted.
>
>> +if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];
> Why / in front of $GIT_BUILD_DIR/ ?
Good point, we didn't noticed it ...
>> +        test_expect_code 0 ls mw_dir | wc -l | grep 1&&
>> +        test_expect_code 0 test -e mw_dir/Main_Page.mw&&
> Why "test_expect_code 0"? You already have&&  right?
Yes, we haven't realised it wasn't necessary.
We have corrected other errors like this one in our tests.
> Doesn't a directory containing 10 files pass the tests?
>
> You probably want a helper function test_contains_N_files<dir>  <N>  =
that
> does test `ls mw_dir | wc -l` -eq 1 as you did below, but may give a
> diagnosis when the test fails.
Done, and replace within the existing code.
>> +test_expect_success 'git clone only create Main_Page.mw with a wiki=
 with no other pages ' '
>> +        wiki_reset&&
>> +        wiki_editpage foo "this page must be delete before the clon=
e" false&&
> s/delete/deleted/
>> +	git_diff_directories mw_dir ref_page&&
> functions in tests are usually prefixed with test_ instead.
=46air enough. We have changed the function's name. Should we add such=20
prefix on functions like wiki_reset or wiki_delete page ?
>> +# clone a wiki after a page has been added then edited once
>> +# check that the content is correct
> It's not sufficient. You should check also that the history is correc=
t.
>
Test is now correct.

Thanks for the advices ;).

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
