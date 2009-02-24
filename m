From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 06:15:46 +0100
Message-ID: <49A38282.8020308@pelagic.nl>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl> <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl> <49A33862.90507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpgB-0007Bc-PO
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZBXFP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 00:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbZBXFP7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:15:59 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:36843 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750707AbZBXFP6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:15:58 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id D54B358BDBA;
	Tue, 24 Feb 2009 06:15:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49A33862.90507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111210>

Tor Arne Vestb=F8 wrote:
> Ferry Huberts wrote:
>> Add an ignored icon to the label decorations page and make
>> sure that it is actually decorated: from now on do not ignore
>> ignored resources during decoration.
>=20
> The reason this was not added in the original series was because that=
's
> kind of the point of ignoring a resource -- you don't want any
> information about it. Also, none of the other team plugins provide
> decorations for ignored resources-
>=20

I could also argue that I want everything to be explicit, even the
status of ignored files :-)

If you look at (for example) TortoiseSVN then you'll see that it does
provide an ignore icon. My icon was sort of 'inspired' by that one.
Don't know if it's on by default though, will have to check that.

> On the other hand, since the decorators are now user configurable,
> adding the option to allow users to enable decoration of ignored
> resources if they really feel it's useful to them is admittedly in li=
ne
> with the whole customization idea.
>=20
> Though I'm not sure if this particular case of customization would ca=
use
> more confusion than good, for example in terms of which doors we open=
 by
> allowing ignored resources to actually not be ignored (i.e what other
> features would you expect to work for ignored resources?).
>=20
>>  		prefs.setDefault(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON, tru=
e);
>> +		prefs.setDefault(UIPreferences.DECORATOR_SHOW_IGNORED_ICON, true)=
;
>>  		prefs.setDefault(UIPreferences.DECORATOR_SHOW_STAGED_ICON, true);
>=20
> If applied, I would argue that the option should be _off_ by default,=
 to
> match the behavior of the other team plugins and the normal logical
> action of ignoring a resource.

not my preference (hey I wrote the patch) but reasonable.

>=20
>> +	/** Decoration for resource ignored by Git */
>> +	public static final ImageDescriptor OVR_IGNORED;
>> +
>=20
> Side-note: the current decoration implementation only uses Eclipse's
> concept of an ignored resource -- not .gitignore et al. since we don'=
t
> have a standard way of reading those yet.
>=20
> Tor Arne
>=20
I've started work on that, see the issue on the issue tracker. The plan
is to hook in on change events and then parse all gitignore files, and
tell eclipse about the contents of the ignores.

=46erry
