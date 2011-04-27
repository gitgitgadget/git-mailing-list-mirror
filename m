From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 21:57:51 +1000
Message-ID: <BANLkTimUPGqVcn743P-Hkf_BaS9XT93=ZQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<20110427113840.GF31730@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3NW-0007wb-DP
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626Ab1D0L5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 07:57:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53856 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab1D0L5w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 07:57:52 -0400
Received: by vws1 with SMTP id 1so1223539vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u/VkgXEgvvqZ/jaYY3zp3O7HMAlROzohhzZiSg+3bgw=;
        b=amgIvablttKGYPqxQ9VefUsOt7Yd/UgJXi7yBdtYs4QbtcpuM1DbQSHeOntr9FPvMB
         l+JL03hJd10MI2NiOs3uvr3l0y/JB9dIlKSFlnVmt61BuFqevAmf65q+UOrEfamlH6xI
         ZOxS0utpZEuulqJX6tuZqMC8kdPeV+D4ObdYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MbbI2ZOqhX+ZaYec9gD6B9jIh1i1fb122aY801x17L+mWVix5zp1+kX7m1OJYozS+5
         5ApjijZwmKFwhOA9uoLr0R7GLN6ZZK5owNvUPZeQk6VVFArHyx8PzUpmYL9shLUoV15F
         FIsvDV+ofnr7Gnf3bCfyuSjBJTfUJnjHMFwg8=
Received: by 10.52.95.108 with SMTP id dj12mr3130068vdb.39.1303905471647; Wed,
 27 Apr 2011 04:57:51 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 04:57:51 -0700 (PDT)
In-Reply-To: <20110427113840.GF31730@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172224>

On Wednesday, April 27, 2011, Fredrik Gustafsson <iveqy@iveqy.com> wrot=
e:
> On Wed, Apr 27, 2011 at 03:33:57PM +1000, Jon Seymour wrote:
>> So, I think at a very minimum, a plugin architecture should specify
>> the file system layout of packages to be managed by a plugin/package
>> manager.
>
> As I recall, Junios initial plan was to have gitk-git as a submodule =
at
> some point. I still thinks this is a good idea.
>
> If we extends the submodule concept, of not only having a list of
> submodules, but also state weather a submodule is 'active' or 'inacti=
ve'
> we could easily get a _very_ customable git.git.
>
> Imagine git.git only containing git. A 'git submodule init' would loa=
d
> the default 'active' submodules (for example git-gui, gitk-gui and
> gitweb), everything in contrib is 'inactive'. The point here is to be
> able to ship references to nice things to have (contrib) but not forc=
e
> the use (download, diskspace, etc.) of it.
>
> If a user finds an other awesome "plugin" to use with git, it's easy =
to
> add it to h{er,i}s repository with 'git submodule add'.
>
> Once the code is downloaded to the git-workspace (via 'git submodule
> update') the git build system ('make') would take care of building an=
d
> installation, just as it does today.
>

=46rederiick,

I have also been think about submodules as one possible back-end
package distribution manager, It certainly makes sense since once can
at least assume git is available :-)

However, it would be only one way, precisely because I will need to
rely on real package managers tif he build step is non-trivial.

Anyway, thanks for your feedback.

Jon.


> --
> Med v=C3=A4nliga h=C3=A4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
>
