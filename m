From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 21:03:48 +1000
Message-ID: <ee77f5c20710140403j7a88ffa4q579a8c4118d8fd71@mail.gmail.com>
References: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih1GM-0007WE-1f
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 13:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbXJNLDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 07:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbXJNLDt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 07:03:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:21155 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbXJNLDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 07:03:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1178830rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=z2+2DnqTgx38pOqbJq3P60LfTX9hxPJ/TNIk87dBpXQ=;
        b=P1kIRF5QHBWsYCQPK/wRbhP/8TOlrudCKwlV3vH2B/9OERPlPtC76e3VZfeJONkvXrjxCi6zTmyAgr588Sz+oGfmLFXuPBxZa39MoFD4LheUYvDxeJU8opUyGjuBI4uVugrRtjhQ2Ii4d2YRrnJLFPuzvaFqDhIOdkKFN18m0yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqR9UwotesVRBzURkR7yOu1PSMWIcQnw+vCS2N/frVlTIbY61M7PlzE9qckykwhqB73eULoETirmO4GOBuatvq5K8WELwFJEqNvMm0TqkNn6fUWkD2lbPl36PWAv5DV9QEFCs84MwVGXUexIqmq21hBEC0jdi+u9yg/ayjr2XBI=
Received: by 10.141.128.19 with SMTP id f19mr2279719rvn.1192359828033;
        Sun, 14 Oct 2007 04:03:48 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sun, 14 Oct 2007 04:03:48 -0700 (PDT)
In-Reply-To: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60828>

On 14/10/2007, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I'm currently exploring the idea of not only making the equivalent of
> "pu" and "next" available on a public repository for one of my projects,
> but also the topics/* branches.   When thinking about how I might do
> this, one snag I ran into is that the topics/foo and topics/bar branches
> are ephemeral, and so when I replicate them to a remote repository,
> either on kernel.org or repo.or.cz, I would need a way of removing a
> head for a topic branch that had already been merged.

git push <remote> :<branch_name>

If the left side of the colon in a push refspec is empty, it deletes
the remote ref given by the right hand side.


Dave.
