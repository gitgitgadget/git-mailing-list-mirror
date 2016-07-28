Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6291F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990AbcG1QJG (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:09:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758941AbcG1QJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 12:09:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06D4A2F400;
	Thu, 28 Jul 2016 12:09:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R50S9740rA1V
	8H2A9d9WlcS5eoo=; b=tXepBGlRLTzbkOCQT1xgaS9OQBoyihsOmtJQsKuf1wYH
	Af0NxsV/pQSs1xCP+eHEu33iFI285y57n5UoSHaZkRNqV81op+k1ATv7Vbes8sBH
	9Xlf6eH5Yd0MHvUavJ9YrXXHmLf2O8BdHiptyGLNRexZH4Y8daahTKVt/1863zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l1DVaM
	pXjfXQ+ksZMSWY2YZXfUo+6T+nOqMp+b/5f9zyiqkQ2CzRFTVWytKbwHUhRj/sTl
	TqbnpKOHttD2oKg8fhs8vd6gNGNgZx3j5hiMWl1dQwpePM3hFel5j+OLNTyizsrG
	CY2o2BuehmiudsPCRYNvu1vG8sz4zXOZb9QoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F02802F3FF;
	Thu, 28 Jul 2016 12:09:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E81A2F3FC;
	Thu, 28 Jul 2016 12:09:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4] i18n: notes: mark comment for translation
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	<1469705175-7503-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Thu, 28 Jul 2016 09:09:00 -0700
In-Reply-To: <1469705175-7503-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 28 Jul 2016 11:26:15 +0000")
Message-ID: <xmqq1t2du4mb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 99AA4FFC-54DD-11E6-A406-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark comment displayed when editing a note for translation.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>
> This patch follows the original output and Ævar Arnfjörð Bjarmason
> sugestion to remove \n from the source string in order to assure that the
> ouput layout is not change by one translator forgetting to add \n, for
> instance.

Well, that cuts both ways.  A translater adding an extra \n would
also break the layout, so I am not convinced that is a very good
justification.

As a parameter to strbuf_add_commented_lines(), an extra or a
missing \n does not really matter, though, because the whole thing
is a line-oriented comment ;-)

As to the patch text, it looks like it would produce more correct
output than what I queued tentatively on 'pu', so I'd replace it
with this one.

>  builtin/notes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 0572051..f848b89 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -91,7 +91,7 @@ static const char * const git_notes_get_ref_usage[] = {
>  };
>  
>  static const char note_template[] =
> -	"\nWrite/edit the notes for the following object:\n";
> +	N_("Write/edit the notes for the following object:");
>  
>  struct note_data {
>  	int given;
> @@ -179,7 +179,8 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
>  			copy_obj_to_fd(fd, old_note);
>  
>  		strbuf_addch(&buf, '\n');
> -		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
> +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
> +		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
>  		strbuf_addch(&buf, '\n');
>  		write_or_die(fd, buf.buf, buf.len);
