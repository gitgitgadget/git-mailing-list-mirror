From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: clean/smudge filters for pdf files
Date: Thu, 23 Oct 2008 21:40:47 -0400
Message-ID: <ee2a733e0810231840u1aed8455w7e4c461e2565ad08@mail.gmail.com>
References: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>
	 <20081023213203.GB26104@artemis.corp>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 03:42:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtBh5-00068g-Pe
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 03:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbYJXBku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 21:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbYJXBku
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 21:40:50 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:59269 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbYJXBkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 21:40:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so423916fkq.5
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0FIS1XwnRG4YHZj1N6W7T7SQeiu9Jn/tNTz7V9WviAA=;
        b=K+2lYFO31OKLPjxJ/925elaFttO+kUVE+UT9Vbu61AiL6NsU7DLHJx/iwxU+mZdMHq
         4gxZ7jifQV0BBNxNI8pbE57BZiv8yixFW7jiZHCWoOnZp5pEl5MJTYtTYDGaCK3ojnoG
         zMThU2oFJanRHZ/kdUCFXjSl9W32H85in1Rjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=TvPVTvtmX8Vz55AoZfJnWxcbVX6RzVgEchh3NbaLvwhj9qGdb7cnKsguPbzsqkD0pQ
         sobBRPg9Nbtcw3B88QJd7j0hPOCwClfzzOdBzYGvoZcuTxsQlnT6cPohRIT7SnFrq09E
         xyjRVuRveYjJyn/3rYOiWn1FQMz7eAfHizOBg=
Received: by 10.187.204.12 with SMTP id g12mr39181faq.107.1224812447103;
        Thu, 23 Oct 2008 18:40:47 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Thu, 23 Oct 2008 18:40:47 -0700 (PDT)
In-Reply-To: <20081023213203.GB26104@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98997>

On 10/23/08, Pierre Habouzit <madcoder@debian.org> wrote:
> On Thu, Oct 23, 2008 at 07:44:39PM +0000, Leo Razoumov wrote:
>  > I am trying to improve storage efficiency for PDF files in a git repo.
>  > Following earlier discussions in this list I am trying to set up
>  > proper clean/smudge filters. What follows is my current setup
>  >
>  > # in ~/.gitconfig
>  > [filter "pdf"]
>  >       clean  = "pdftk - output - uncompress"
>  >       smudge = "pdftk - output - compress"
>  >
>  > # in .gitattributes
>  > *.pdf filter=pdf
>  >
>  > Unfortunately, it seems as though that pdftk uncompress followed by
>  > pdftk compress do not leave the file invariant. I tried several
>  > uncompress+compress iterations and the file still keep changing (the
>  > size though stays the same).
>  > Is there any other alternative way to store PDF files in git repo more
>  > efficiently?
>  > Any alternative to pdftk on Linux?
>
>
> actually it uses some kind of zlib algorithm so that's pretty normal you
>  don't have the same result with a packer. Maybe one could write a tool
>  like pristine-tar for that purpose.
>

With zlib you get the same deterministic result as long as you use the
same zlib packer and unpacker. With pdftk compress/uncompress seem not
to form a bijection pair. This issue was briefly discussed on this
list back in April 2008 but no resolution emerged.

--Leo--
