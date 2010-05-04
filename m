From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Shell aliases & paths
Date: Tue, 4 May 2010 16:11:22 -0500
Message-ID: <20100504211122.GA15091@progeny.tock>
References: <19424.34226.564684.613674@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue May 04 23:11:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9POi-0006Jc-4f
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762Ab0EDVLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 17:11:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44275 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933754Ab0EDVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 17:11:08 -0400
Received: by pwi5 with SMTP id 5so474494pwi.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xuXcP59FEOriNE19r0PgJxErgIRG+5qHDi//m73EuxQ=;
        b=YMBWgJOTHQC09qo9+0wXzwnS/+hD2G51mlTW4GrLrrMZne/pLjegmVdJ+51+lYLDJn
         YydX/z4L4NnEezXSYkJliRDh4gZaQfqlC8VV1a8gCSVNfpny0VrqTyRq3S6qXbWLYhrJ
         vhSgDDcSlmQx16p/o6fi88YMO//e4S48t8KSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aLccQBXbFf+jUoBrrjgUHP2guE5T/yAAGL3nCW/yIoILfb0tJgVPF2QwWAGMsYK8GV
         qbflw1CRa8ziwEScOMHUjx1gfBEH6C5Waew1LfZeF6tGMYa4vVtMTQFSQpmd9mnvdth9
         DfRizm4zQpXKG36X2NDH0jqYi3sdxGHUAbwLM=
Received: by 10.142.210.15 with SMTP id i15mr3377841wfg.256.1273007466404;
        Tue, 04 May 2010 14:11:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u18sm863295wfh.19.2010.05.04.14.11.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 14:11:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19424.34226.564684.613674@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146345>

Eli Barzilay wrote:

> AFAICT, a shell command alias (one that starts with a "!") is execute=
d
> from the repository root, but to make things worse it looks like ther=
e
> is no way to tell which directory it was executed from.  If this is
> correct, then these aliases are useless for anything that need to
> accept relative paths.  Is there something obvious that I'm missing?

Not that I can see.  Maybe a new GIT_PATHNAME_PREFIX environment variab=
le
would help.

If we were starting from scratch, it might be nice to make aliases
suppress the chdir to toplevel.  Unfortunately, that would probably
break some existing aliases.  Another possibility would be to use some
alternative convention (like [alias] foo =3D "# bar") to suppress the
repository search.  At that point, why not just add a git-foo script
to $PATH?  (=E2=80=98git foo=E2=80=99 will still call it.)

Hope that helps,
Jonathan
