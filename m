From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git svn --add-author-from implies --use-log-author
Date: Mon, 23 Jun 2008 17:31:43 -0400
Message-ID: <32541b130806231431r61da1f02v663463cedb5b96ef@mail.gmail.com>
References: <20080620113147.GC27940@frsk.net>
	 <485BB134.9080203@mircea.bardac.net>
	 <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
	 <48601432.2090707@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mircea Bardac" <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:34:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAteW-0005Ma-Qc
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFWVbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYFWVbt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:31:49 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:52982 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbYFWVbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:31:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2481362fkq.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S8iLLSobjrbuwAIThcLTMuNH/gXHdH+ZXMSoKfUHb2Y=;
        b=IKfsv70dAuPNpGSRSIo/rOpfB5Y0z1jkR3sCTva07R+O7XnYmIxvecZz/ncBjVUcsa
         nfQsTjcqiV/lGy18wY6bBxsFp7oQAhFxdM4qzW16BqazG3uPLbOPidFN7qXtQ5sQQHTN
         K0GWXL1ajQMVxGJ/Y+tsu4/SIxPRnX8RDCFGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LHDwxD3jtydUBMEXIzENppP05YYBtytLwn4YPMtYktcSOzuaiqw3mmMeAaGiSkqyYM
         KZeLRd27hweDi1FerS72JqGx4w4XNeaL4w4zDpDuT65RyORqMcscWIb/i4gphXYbEXop
         3kJd9fc12kxfWTNMEjWLnuH1VuI+gNHHG2tA8=
Received: by 10.82.176.11 with SMTP id y11mr522888bue.53.1214256703964;
        Mon, 23 Jun 2008 14:31:43 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Mon, 23 Jun 2008 14:31:43 -0700 (PDT)
In-Reply-To: <48601432.2090707@mircea.bardac.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85937>

On 6/23/08, Mircea Bardac <dev@mircea.bardac.net> wrote:
>  Avery Pennarun wrote:
>
> > You can set config options for these, however:
> >
> > git config svn.addAuthorFrom true
> > git config svn.useLogAuthor true
> >
> > (I actually use "git config --global" to set these on my system so
> > they apply to all my git-svn repositories.)
>
>  Oh great. This is what I actually wanted. Makes a lot more sense to have
> them as (global) variables.
>
>  My initial thought was that there are (somewhere) some variables being set
> for the repository by using --add-author-from and --use-log-author with "git
> svn clone ...". I find this quite intuitive (and maybe this should be
> default?). I can't see a reason for using these options once and not using
> them later, but it might just be me.

I agree, it's a good idea to save them to the config at git svn clone time.

When I added --add-author-from I just did it like --use-log-author,
then I had to read the source code to find out how to set them as
config variables :)

I'm sure some patches (at least for the documentation) would be welcomed.

>  I have found that Documentation/SubmittingPatches contains info on how to
> use "Signed-off-by:"/"Acked-by:"/a little bit of "From:" but, as far as I
> remember, others have been/are used. Are they all gathered somewhere, as
> recommendations?

I don't know of any definitive reference, but Signed-off-by and
Acked-by seem to be the important ones.  From: (as part of the commit
message) seems to be a git-svn extension that I invented.  From: (as a
header in the commit message) is interpreted as the committer name by
git-am, I think, but you almost never need that.

Have fun,

Avery
