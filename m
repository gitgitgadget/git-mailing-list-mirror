From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC] Teach fast-import to import subtrees named by tree
 id
Date: Fri, 2 Jul 2010 14:44:31 +0200
Message-ID: <20100702124431.GB2306@debian>
References: <20100701031819.GA12524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 14:46:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUfdq-000058-5U
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 14:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0GBMmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 08:42:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59676 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0GBMmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 08:42:53 -0400
Received: by wyf23 with SMTP id 23so1143475wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=06fXCDKlcs4kwPFBEIgHVAytc1/mxfqI78weA0so3/U=;
        b=he4h+/q9iuNNfSkgFmfJD6yUBmbXVeGuPPMZ/MRlNEdC+FGqtPJJOU7vzEa62ibORd
         srVZUFAdTkNWx7fS/BZszJBFftJLoPpkyYcsY7o3FCnQ2MNSV3KPOoEiKNjUED7Qo/Is
         jRd/E4hXWTtAqZpqVM+jMc/URw+G2rw+GL8Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=Do5z14tkA6SI0ASxDBALxVY103+T/V00jt60t/jD6MCDVuIvyyB4G0K2rXykDH+MHh
         xmPV6sDLsnr0I01h6LBCu4CtlsXdHoH4nRHpQwq3bDIDTfM/t5Mr6Gay1uwEmdulMpdB
         2IPA5f4JwHRuiYlSUWN8HsK/Ff3JBLOYnvenM=
Received: by 10.213.28.134 with SMTP id m6mr3871420ebc.17.1278074571804;
        Fri, 02 Jul 2010 05:42:51 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm5254006eei.0.2010.07.02.05.42.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 05:42:47 -0700 (PDT)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20100701031819.GA12524@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150124>

Hi Jonathan,

Jonathan Nieder writes:
> To simulate the svn cp command, it would be very useful to be
> replace an arbitrary file in the current revision by an
> arbitrary directory from a previous one.  Modify the filemodify
> command to allow that:
>=20
>  M 040000 <tree id> pathname
>=20
> This would be most useful in combination with a facility to
> print the commit ids for new revisions as they are written.

Thanks for this patch! I applied and tested it: works as
expected. It's ready for inclusion, yes?

Reviewed-by: Ramkumar Ramachandra <artagnon@gmail.com>

> ---
> I actually thought fast-import already did this until David
> mentioned that no, it does not.  Well, live and learn.
>=20
> This and Sverre=E2=80=99s --print-marks command would allow svn-fe
> to be simplified a great deal.
>=20
> I was not sure whether to add a "feature" specification for
> this, so I=E2=80=99ll try that as a separate patch.
>=20
> Thoughts?
> Jonathan
>=20
>  Documentation/git-fast-import.txt |    8 ++++-
>  fast-import.c                     |   24 ++++++++++------
>  t/t9300-fast-import.sh            |   54 +++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 75 insertions(+), 11 deletions(-)
>=20
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fa=
st-import.txt
> index 19082b0..f4d9aeb 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -482,9 +482,11 @@ External data format::
>  	'M' SP <mode> SP <dataref> SP <path> LF
>  ....
>  +
> -Here `<dataref>` can be either a mark reference (`:<idnum>`)
> +Here usually `<dataref>` must be either a mark reference (`:<idnum>`=
)
>  set by a prior `blob` command, or a full 40-byte SHA-1 of an
> -existing Git blob object.
> +existing Git blob object.  If `<mode>` is `040000`` then
> +`<dataref>` must be the full 40-byte SHA-1 of an existing
> +Git tree object or a mark reference set with `--import-marks`.
> =20
>  Inline data format::
>  	The data content for the file has not been supplied yet.
> @@ -509,6 +511,8 @@ in octal.  Git only supports the following modes:
>  * `160000`: A gitlink, SHA-1 of the object refers to a commit in
>    another repository. Git links can only be specified by SHA or thro=
ugh
>    a commit mark. They are used to implement submodules.
> +* `040000`: A subdirectory.  Subdirectories can only be specified by
> +  SHA or through a tree mark set with `--import-marks`.
> =20
>  In both formats `<path>` is the complete path of the file to be adde=
d
>  (if not already existing) or modified (if already existing).
> diff --git a/fast-import.c b/fast-import.c
> index 1e5d66e..ad6843a 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2131,6 +2131,7 @@ static void file_change_m(struct branch *b)
>  	case S_IFREG | 0644:
>  	case S_IFREG | 0755:
>  	case S_IFLNK:
> +	case S_IFDIR:
>  	case S_IFGITLINK:
>  		/* ok */
>  		break;
> @@ -2176,23 +2177,28 @@ static void file_change_m(struct branch *b)
>  		 * another repository.
>  		 */
>  	} else if (inline_data) {
> +		if (S_ISDIR(mode))
> +			die("Directories cannot be specified 'inline': %s",
> +				command_buf.buf);

Okay. Since you've passed S_IFDIR in the earlier switch-case, you've
made sure that directories aren't specified inline here.

>  		if (p !=3D uq.buf) {
>  			strbuf_addstr(&uq, p);
>  			p =3D uq.buf;
>  		}
>  		read_next_command();
>  		parse_and_store_blob(&last_blob, sha1, 0);
> -	} else if (oe) {
> -		if (oe->type !=3D OBJ_BLOB)
> -			die("Not a blob (actually a %s): %s",
> -				typename(oe->type), command_buf.buf);
>  	} else {
> -		enum object_type type =3D sha1_object_info(sha1, NULL);
> +		enum object_type expected =3D S_ISDIR(mode) ?
> +						OBJ_TREE: OBJ_BLOB;
> +		enum object_type type =3D oe ? oe->type :
> +					sha1_object_info(sha1, NULL);

Instead allowing just blobs, you've allowed both blob and tree objects
to be specified here. I don't see any tree writing code in your
change, so I'm assuming blob and tree writing is just handled
transparently in Git.

>  		if (type < 0)
> -			die("Blob not found: %s", command_buf.buf);
> -		if (type !=3D OBJ_BLOB)
> -			die("Not a blob (actually a %s): %s",
> -			    typename(type), command_buf.buf);
> +			die("%s not found: %s",
> +					S_ISDIR(mode) ?  "Tree" : "Blob",
> +					command_buf.buf);
> +		if (type !=3D expected)
> +			die("Not a %s (actually a %s): %s",
> +				typename(expected), typename(type),
> +				command_buf.buf);
>  	}
>  	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);

Conditionally printing either "blob" or "tree" in the error message. Ok=
ay.

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 131f032..50d5913 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh

Okay. Test passes.

-- Ram
