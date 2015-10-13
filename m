From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/44] refs-be-files.c: add a backend method structure
 with transaction functions
Date: Tue, 13 Oct 2015 09:56:09 +0200
Message-ID: <561CB919.8000801@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 10:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZluYR-0003tI-NK
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 10:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbbJMIDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 04:03:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50369 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbbJMIDN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 04:03:13 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2015 04:03:13 EDT
X-AuditID: 12074414-f794f6d000007852-f1-561cb91b7e45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.BB.30802.B19BC165; Tue, 13 Oct 2015 03:56:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D7u9UR018114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 03:56:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-21-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqCu9UybM4OgkcYv5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAndF3v5+5YBNPxfF7h1gaGD9y
	djFyckgImEjMuvadEcIWk7hwbz1bFyMXh5DAZUaJHae6WSGcs0wSszatYAap4hXQljj8fxMb
	iM0ioCpxa/9/FhCbTUBXYlFPMxOILSoQJLFi+QtGiHpBiZMzn4DViAg4SFzedRRsDrOApsSm
	DS9YQWxhgSyJuT+vs0Asa2OU6Hz1CyzBKeAl8WVzJxtEg57EjusQcWYBeYntb+cwT2AUmIVk
	xywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERK8IjsYj5yU
	O8QowMGoxMP7IlImTIg1say4MvcQoyQHk5Ior+gOoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3qQWoBxvSmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgSvE8hQwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFC0xhcD4xUkxQO0NwOknbe4IDEXKArReopRUUqc
	twgkIQCSyCjNgxsLS0mvGMWBvhTmPb4dqIoHmM7gul8BDWYCGmzELgUyuCQRISXVwLiEReqj
	+vR3WiaNmc8ij7a67nvGahQXF32fqVp/vuLND4cWN0qzrvvcrMS4XXjFvIerWXqSXxp2f5vR
	VXdndtwN5eY209KqR8tPmP103VgVzlJ88uqJ5ZcPsQUYa26TaN5YwLJe0Kt7bVmf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279488>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Add a ref structure for backend methods. Start by adding a method pointer
> for the transaction commit function.
> 
> Add a function set_refs_backend to switch between backends. The files
> based backend is the default.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 10 ++++++++--
>  refs.c          | 30 ++++++++++++++++++++++++++++++
>  refs.h          | 15 +++++++++++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index 4940ae9..419abf4 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -619,4 +619,19 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>  			 reflog_expiry_cleanup_fn cleanup_fn,
>  			 void *policy_cb_data);
>  
> +/* refs backends */
> +typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
> +				      struct strbuf *err);
> +typedef void ref_transaction_free_fn(struct ref_transaction *transaction);

The ref_transaction_free_fn typedef isn't used anywhere.

> +struct ref_be {
> +	struct ref_be *next;
> +	const char *name;
> +	ref_transaction_commit_fn *transaction_commit;
> +};
> +
> +
> +extern struct ref_be refs_be_files;

I don't think that refs_be_files is needed in the public interface.

> +int set_refs_backend(const char *name);
> +
>  #endif /* REFS_H */

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
