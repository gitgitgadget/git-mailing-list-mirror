From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import: multiple processes possible?
Date: Sat, 27 Nov 2010 14:28:17 -0800
Message-ID: <AANLkTi=ZH+GNZyPSbafuDEE5nsFtezoePK+gFtM6HrEX@mail.gmail.com>
References: <8739qmzaha.fsf@matica.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Zimmerman <itz@buug.org>
X-From: git-owner@vger.kernel.org Sat Nov 27 23:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMTJr-0002xj-Ai
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 23:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab0K0W2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 17:28:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62042 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0K0W2i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 17:28:38 -0500
Received: by iwn5 with SMTP id 5so302704iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 14:28:37 -0800 (PST)
Received: by 10.231.16.131 with SMTP id o3mr3433562iba.38.1290896917350; Sat,
 27 Nov 2010 14:28:37 -0800 (PST)
Received: by 10.231.154.5 with HTTP; Sat, 27 Nov 2010 14:28:17 -0800 (PST)
In-Reply-To: <8739qmzaha.fsf@matica.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162329>

On Sat, Nov 27, 2010 at 2:07 PM, Ian Zimmerman <itz@buug.org> wrote:
>
> Hi, I have a user question, I hope that's ok. =A0Actually, the end go=
al is
> development of a fast-import frontend. =A0The fast-import manpage say=
s
> that it is safe to run "any other" git operation concurrently with
> fast-import. =A0It doesn't say if it is possible and safe to run anot=
her
> copy of fast-import itself.

Yes, you can.

The only problem is, each fast-import cannot see the objects created
by the other concurrent fast-imports until they either terminate, or
execute "checkpoint" command received from the frontend.

--=20
Shawn.
