From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 3/3] tests: Add 'rebase -i commits that overwrite untracked
 files'
Date: Tue, 27 May 2014 15:15:46 +0200
Message-ID: <53849002.7060502@alum.mit.edu>
References: <533C913C.20106@cisco.com> <5383BDF0.2040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 15:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpHEP-0002HP-LV
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 15:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbaE0NPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 09:15:49 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56878 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019AbaE0NPt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 09:15:49 -0400
X-AuditID: 12074413-f79bc6d000000b9e-8b-53849004cc5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.29.02974.40094835; Tue, 27 May 2014 09:15:48 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1362.dip0.t-ipconnect.de [93.219.19.98])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4RDFkq0008104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 27 May 2014 09:15:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <5383BDF0.2040904@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqMsyoSXYYNopHotDc++xW3Rd6Way
	OHX0O6sDs8eU3xtZPXbOusvu8XmTXABzFLdNUmJJWXBmep6+XQJ3RtvO50wFa+Qr/s2qa2C8
	KNHFyMkhIWAi8WnmfRYIW0ziwr31bF2MXBxCApcZJfp3XWOFcM4xSSw9NI0ZpIpXQFti4cqX
	TF2MHBwsAqoSP06bgoTZBHQlFvU0g4VFBYIk/pxVhKgWlDg58wnYfBEBc4njO2axg9jMAvIS
	m09eYgUpFxYIk1h4Ih0kLCTgLNFz9xJYCaeApsT2xkZmkBIJAXGJnsYgiE4diXd9D5hhpmx/
	O4d5AqPgLCTLZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2M
	kGAW3sG466TcIUYBDkYlHt6Jvs3BQqyJZcWVuYcYJTmYlER5lbpagoX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8PL3AeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	y0AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRG18MjF2QFA/Q3n1ge4sLEnOB
	ohCtpxh1OU7dOdbGJMSSl5+XKiXO29cLVCQAUpRRmge3Apa6XjGKA30szNsNMooHmPbgJr0C
	WsIEtGRHRyPIkpJEhJRUA+PCR5ZiIdtsL5jfTVu0y9vqpv1VCZaVAn/m55qXLnSYFiQjp3Lx
	TsaS7bP3bP/13eWk3sJP6rN+rdv7k8Hk+pxJCoZbBfp2fXm7W+r+TZ7p7hq/49Su 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250165>

On 05/27/2014 12:19 AM, Fabian Ruch wrote:
> If a todo list will cherry-pick a commit that adds some file and the
> working tree already contains a file with the same name, the rebase
> sequence for that todo list will be interrupted and the cherry-picked
> commit will be lost after the rebasing process is resumed.
> 
> This is fixed.
> 
> Add as a test case for regression testing to the "rebase-interactive"
> test suite.

The tests look fine.  (I assume you tested the tests against the
pre-fixed version of the software to make sure that they caught the
problem that you fixed.)

As I mentioned in patch 2/3, I think it would be better to add the tests
in the same commit where you fix the problem.

The commit message is, I think, confusing because the first paragraph is
in future tense even though it is describing a problem that was just
fixed.  It will probably change completely when you squash this with the
previous commit, but for future reference, I would have suggested
something more like

    t3404: "rebase -i" retries pick when blocked by untracked file

    If a commit that is being "pick"ed adds a file that already exists
    as an untracked file in the working tree, cherry-pick fails before
    even trying to apply the change.  "rebase --interactive" didn't
    distinguish this error from a conflict, and when "rebase --continue"
    was run it thought that the user had just resolved and committed
    the conflict.  The result was that the commit was omitted entirely
    from the rebased series.

    This problem was fixed in the previous commit.  Add tests.

> Reported-by: Phil Hord <hordp@cisco.com>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 50e22b1..7f5ac18 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1074,4 +1074,48 @@ test_expect_success 'short SHA-1 collide' '
>  	)
>  '
>  
> +test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
> +	git checkout branch2 &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i A &&
> +	test_cmp_rev HEAD F &&
> +	test_path_is_missing file6 &&
> +	touch file6 &&
> +	test_must_fail git rebase --continue &&
> +	test_cmp_rev HEAD F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test_cmp_rev HEAD I
> +'
> +
> +test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
> +	git checkout branch2 &&
> +	git tag original-branch2 &&

It might be easier (and better decoupled from other tests) to

        git checkout -b squash-overwrite branch2 &&

rather than moving branch2 then resetting it.  That way you can also
leave the branch in the repo when you are done rather than having to
clean it up.

> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 squash 2" git rebase -i A &&
> +	test_cmp_rev HEAD F &&
> +	test_path_is_missing file6 &&
> +	touch file6 &&
> +	test_must_fail git rebase --continue &&
> +	test_cmp_rev HEAD F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
> +	git reset --hard original-branch2
> +'
> +
> +test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
> +	git checkout branch2 &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i --no-ff A &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
> +	test_path_is_missing file6 &&
> +	touch file6 &&
> +	test_must_fail git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = I
> +'
> +
>  test_done
> 

Thanks!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
