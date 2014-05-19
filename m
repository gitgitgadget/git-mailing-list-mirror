From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Tue, 20 May 2014 01:40:54 +0300
Message-ID: <20140519224054.GB29605@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
 <1400447743-18513-4-git-send-email-mst@redhat.com>
 <xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 00:42:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWG1-0001n3-4F
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbaESWmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14515 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbaESWmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:42:03 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4JMg0eX000815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 19 May 2014 18:42:00 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4JMfxoP012221;
	Mon, 19 May 2014 18:41:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249630>

On Mon, May 19, 2014 at 02:34:26PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > test ack! handling
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Will queue with this squashed in.

Thanks! And sorry about the style issues.

> 4/4 seems to have some style issues as well, but I didn't look very
> closely.

I'll try to clean it for the next submission.
I'll be glad to hear about them as well.
Thanks!

> Thanks.
> 
>  t/t3415-rebase-autosquash.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 9d7db13..dcdba6f 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -75,18 +75,18 @@ test_expect_success 'auto squash (option)' '
>  '
>  
>  test_expect_success 'auto ack' '
> -	ack="Acked-by: xyz"
> -	msg=$(test_write_lines "ack! first commit" "" "$ack")
> +	ack="Acked-by: xyz" &&
> +	msg=$(test_write_lines "ack! first commit" "" "$ack") &&
>  	git reset --hard base &&
>  	git commit --allow-empty -m "$msg" -- &&
>  	git tag ack &&
>  	test_tick &&
>  	git rebase --autosquash -i HEAD^^^ &&
>  	git log --oneline >actual &&
> -	git show -s first-commit | grep -v ^commit > expected-msg &&
> -	echo "    $ack" >> expected-msg &&
> -	git show -s HEAD^ | grep -v ^commit > actual-msg &&
> -	diff actual-msg expected-msg
> +	git show -s first-commit | grep -v ^commit >expected-msg &&
> +	echo "    $ack" >>expected-msg &&
> +	git show -s HEAD^ | grep -v ^commit >actual-msg &&
> +	test_cmp actual-msg expected-msg
>  '
>  
>  test_expect_success 'auto squash (config)' '
