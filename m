From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Sat, 12 Apr 2008 14:26:31 +0800
Message-ID: <46dff0320804112326v7beccd1dp3dc9fdb5c81bb25d@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
	 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804112102t52a60072rc97c772a1e74f597@mail.gmail.com>
	 <7vej9blk4j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 08:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkZD0-0005IY-PN
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 08:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYDLG0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYDLG0c
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 02:26:32 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:35944 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbYDLG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 02:26:32 -0400
Received: by an-out-0708.google.com with SMTP id d31so188467and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4AgX9J6Dp6FgT4msiXRkArgrx4YGxWw7v0kpF+8Y1UI=;
        b=J5PGIiIE7VQyTp7W2jQqCG3/vl07ieLhL6vvQ0xcUId8ZuGuvkEwVQLKOS6QM8fH2PQUbXKbY2nY3qu2rbEX8EvgWhL/8MqH1OiCa2RDMc3Cu1U3Kd3knFJiREi/9P6fWr8+Gcz7CwlJFR1KC/eQk/7Pnrq11EaKP6q09E4dmGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQYeKAS35jS9iDwR0p/usUeI5xv0zkMxlHp08ncAyt/v/lGqfAGrLxT3ZJuj+K+Nimdr2hLobzbIiUN1Gr50wqTydTt5NN1dXeWZpPcvtBsT+N5Vl4hvcAOlzyhBPHTn0+io7ZlXz+R+guNYZlbIBG0rSgD7SZRfv3xLkF9vGQw=
Received: by 10.100.171.10 with SMTP id t10mr7029790ane.72.1207981591054;
        Fri, 11 Apr 2008 23:26:31 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 23:26:31 -0700 (PDT)
In-Reply-To: <7vej9blk4j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79335>

On Sat, Apr 12, 2008 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>
> >>  After working with the project for a while (i.e. you pull and perhaps push
>  >>  back or send patches upstream), .gitmodules file changes and it now says
>  >>  the repository resides at host B.xz because the project relocated.  You
>  >>  would want the next "git submodule update" to notice that your .git/config
>  >>  records a URL you derived from git://A.xz/project.git/, and that you have
>  >>  not seen this new URL git://B.xz/project.git/, and give you a chance to
>  >>  make adjustments if needed.
>  >
>  > I think this should be done if "git submodule update" fails. The
>  > reason it fails may be different, such as newest commits not pushed
>  > out and the subproject relocated etc. So it can only given some hints
>  > with "maybe".
>  >
>  > However, how to detect the url has changed in .gitmodules? Compare the
>  > latest two version of .gitmodules?
>
>  That's why I suggested (and Roman seems to have got it, so I do not think
>  what I wrote was too confusing to be understood) you should record the set
>  of _all_ URLs you have _seen_ in .git/config.  If the URL in .gitmodules
>  checked out is included in that set, you do not do anything.  Otherwise
>  you ask.

I don't think it deserves such a change (say recoding history urls to
$GIT_DIR/config) to just ask just the user whether to change url in
$GIT_CONFIG/config when the url in .gitmodules changes to a new one.

Actually, i think this is an ugly solution :-)

>
>  I think "git submodule update" is a good place to do that check, but I'd
>  prefer it be done _before_ it actually goes to the network to start
>  accessing potentially stale URL.  The old URL may not be defunct but the
>  project decided not to advertise it to be used for some non-technical
>  reason (e.g. the site owner asked them not to point at it and instead use
>  some other mirrors).

If only the protocol (such as http://->git://) is different between
urls in $GIT_DIR/config and .gitmodules, i think use
"url.base.insteadOf = newbase" is simpler.

If the urls are totally different, when url in .gitmodules changes,
there is little chance that the url in $GIT_DIR/config will also
change.


-- 
Ping Yin
