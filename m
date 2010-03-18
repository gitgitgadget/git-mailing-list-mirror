From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes.c: remove inappropriate call to return
Date: Thu, 18 Mar 2010 16:37:34 +0100
Message-ID: <201003181637.35168.johan@herland.net>
References: <m6P-Qdljqt7xCgOUC581DdkndLOwc9aVqzGi_vEsC8UeEeGnpREXOnx-fSQIkTfaqsh9HzzlXIM@cipher.nrlssc.navy.mil> <FMCfttz0yXy1PiW0rQs7llBXL-J_qvqMmKHhFzRD_pqpDVu1DBh0TUAi68oer0RcT3kMvGDNHiQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 16:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsHnm-0000Ng-Oa
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 16:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0CRPiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 11:38:21 -0400
Received: from smtp.opera.com ([213.236.208.81]:36696 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab0CRPiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 11:38:21 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2IFbZfQ020169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Mar 2010 15:37:44 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <FMCfttz0yXy1PiW0rQs7llBXL-J_qvqMmKHhFzRD_pqpDVu1DBh0TUAi68oer0RcT3kMvGDNHiQ@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142479>

On Thursday 18 March 2010, Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
>
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> Heh, I guess it's ok to call 'return' in a function returning
> void, but it shouldn't be passed an argument. :)
>
> -brandon
>
>
>  notes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index a4f9926..07941b7 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -893,7 +893,7 @@ void remove_note(struct notes_tree *t, const
> unsigned char *object_sha1) assert(t->initialized);
>  	hashcpy(l.key_sha1, object_sha1);
>  	hashclr(l.val_sha1);
> -	return note_tree_remove(t, t->root, 0, &l);
> +	note_tree_remove(t, t->root, 0, &l);
>  }
>
>  const unsigned char *get_note(struct notes_tree *t,

Yes, I noticed this during a recent code review in some related code, 
but I haven't yet got around to posting a cleanup patch.

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
