From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Thu, 12 Feb 2015 15:12:08 -0800
Message-ID: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
References: <54CA3611.1000804@statsbiblioteket.dk>
	<1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
	<20150130230516.GA7867@vauxhall.crustytoothpaste.net>
	<a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:12:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2vm-0003R5-B3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbbBLXMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:12:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbBLXMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:12:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24357380D7;
	Thu, 12 Feb 2015 18:12:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fqYY+PsoMynPOrQ6Ww2XZUfEH0o=; b=eKPQjR
	y1QknCyZ42txvdgePsU1YmiSdywg07pkoLV/X0fBjUZLl9EKnVDXJuwWHqiAJlbA
	NgVMza5RWwnPlOjulpdHAhIiHTE0kZnL6fs2TNqWJFE8wYG6qcgQLwv2KPViWOBP
	5gGOk9X3+MHjftB6XCS8Hf661d0OyITMgJ6pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOYk+po43NgniHR9pF2dv1LLn2ZEtIHA
	571iA8KDxpRDuUppPZfCdi5RZ9i+vwnfuhc3QowYoRwImwzhJeMfAWVHaQIcKNsO
	BTyUQn+o/ECx8DiIVCyh6HgD9jYy4HxkFR3XHXSCEJzHyVaOW39s5QhOt/0/sCyE
	z7fV/cc0Quw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B23F380D6;
	Thu, 12 Feb 2015 18:12:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7F31380D5;
	Thu, 12 Feb 2015 18:12:09 -0500 (EST)
In-Reply-To: <a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 30 Jan 2015 18:40:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 92121F28-B30C-11E4-B94C-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263785>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Since it's really not very difficult or invasive to add support for  
> the no- variants, here's a patch to do so:

I am inclined to replace the tc/t9001-noxmailer topic that has been
sitting on my Undecided pile with this patch and move it forward.

    * tc/t9001-noxmailer (2015-01-30) 1 commit
     - t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'

Please stop me if I am missing something obviously wrong with this
plan.

Thanks.



> -- 8< --
> Subject: [PATCH] git-send-email.perl: support no- prefix with older GetOptions
>
> Only Perl version 5.8.0 or later is required, but that comes with
> an older Getopt::Long (2.32) that does not support the 'no-'
> prefix.  Support for that was added in Getopt::Long version 2.33.
>
> Since the help only mentions the 'no-' prefix and not the 'no'
> prefix, add explicit support for the 'no-' prefix when running
> with older GetOptions versions.
>
> Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  git-send-email.perl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3092ab35..a18a7959 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -299,6 +299,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "bcc=s" => \@bcclist,
>  		    "no-bcc" => \$no_bcc,
>  		    "chain-reply-to!" => \$chain_reply_to,
> +		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
>  		    "smtp-server=s" => \$smtp_server,
>  		    "smtp-server-option=s" => \@smtp_server_options,
>  		    "smtp-server-port=s" => \$smtp_server_port,
> @@ -311,25 +312,34 @@ my $rc = GetOptions("h" => \$help,
>  		    "smtp-domain:s" => \$smtp_domain,
>  		    "identity=s" => \$identity,
>  		    "annotate!" => \$annotate,
> +		    "no-annotate" => sub {$annotate = 0},
>  		    "compose" => \$compose,
>  		    "quiet" => \$quiet,
>  		    "cc-cmd=s" => \$cc_cmd,
>  		    "suppress-from!" => \$suppress_from,
> +		    "no-suppress-from" => sub {$suppress_from = 0},
>  		    "suppress-cc=s" => \@suppress_cc,
>  		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
> +		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
>  		    "cc-cover|cc-cover!" => \$cover_cc,
> +		    "no-cc-cover" => sub {$cover_cc = 0},
>  		    "to-cover|to-cover!" => \$cover_to,
> +		    "no-to-cover" => sub {$cover_to = 0},
>  		    "confirm=s" => \$confirm,
>  		    "dry-run" => \$dry_run,
>  		    "envelope-sender=s" => \$envelope_sender,
>  		    "thread!" => \$thread,
> +		    "no-thread" => sub {$thread = 0},
>  		    "validate!" => \$validate,
> +		    "no-validate" => sub {$validate = 0},
>  		    "transfer-encoding=s" => \$target_xfer_encoding,
>  		    "format-patch!" => \$format_patch,
> +		    "no-format-patch" => sub {$format_patch = 0},
>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>  		    "compose-encoding=s" => \$compose_encoding,
>  		    "force" => \$force,
>  		    "xmailer!" => \$use_xmailer,
> +		    "no-xmailer" => sub {$use_xmailer = 0},
>  	 );
>  
>  usage() if $help;
> --
