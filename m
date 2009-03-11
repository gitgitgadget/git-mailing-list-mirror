From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 11:39:06 -0400
Message-ID: <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
	 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Holaday <tlholaday@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQY2-00036I-W8
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZCKPjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZCKPjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:39:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:55445 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbZCKPjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:39:08 -0400
Received: by rv-out-0506.google.com with SMTP id g37so55557rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l+orvGlhis4BTlplarX/FQOWuN8Az56xSHyOaheb+uM=;
        b=Z+GFI3veOzkKvnc6MKdCYL7Rd/j1+CJpibtBbDWYydlBeDK2rUcoiES6z5Fe/OsLKF
         YJNFpATvo2U0QEFpVTtTQGd/Tpde7H9s1BNnPTsgcuLugPWfIYCfIR1AQdRSlElf8LrA
         dhHB+ILwW2ZcxiP88mY8iCZN4iQIgTrJZhwGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j3pYEVwTak4ZKa7eGOwFEiGfJ1ce3tnVW9bsRB4yphgiyQyX5x/rxhURYw/ZYQbuG4
         Iy4HOlVbivRBFt9D25wEtJ1V1MzAwFE4VIT8edX/EG/P+iq7svm7rXnBSrWik6J1VJEe
         5u7MRZD6Tzsn5DPJU4/3dB9ZkdDiCPnp9ciKc=
Received: by 10.141.202.14 with SMTP id e14mr16692rvq.256.1236785946383; Wed, 
	11 Mar 2009 08:39:06 -0700 (PDT)
In-Reply-To: <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112943>

On Wed, Mar 11, 2009 at 11:12 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> And your man pages still won't be perfect. Preformatted text will loo=
k
> like this:
>
> =C2=A0.ft C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0.ft

Hmm. git-help.txt has this text:

---snip---
------------------------------------------------
	[man]
		viewer =3D konqueror
		viewer =3D woman
------------------------------------------------
---snap---

Which gets translated to:

---snip---
<literallayout>
&#10;.ft C&#10;        [man]
                viewer =3D konqueror
                viewer =3D woman&#10;.ft&#10;
</literallayout>
---snap---

While git-push has this text:

---snip---
+
--------------------------
git push public         #1
git push --repo=3Dpublic  #2
--------------------------
+
---snap---

Which gets translated to:

---snip---
<screen>git push public         #1
git push --repo=3Dpublic  #2</screen>
---snap---

Both appear to render identically after being transformed into html,
but the transformation to man pages leaves the ".ft C" and ".ft"
macros literally in the resultant text. This is using asciidoc 8.3.1
and docbook-xsl 1.74.0. Further investigation is in order, but the
transformation from asciidoc to man pages is currently deep magic to
me.

j.
