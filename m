From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Fri, 20 Mar 2009 15:13:53 -0400
Message-ID: <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com>
References: <20090318100512.GA7932@linux.vnet>
	 <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
	 <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
	 <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302>
	 <20090320064813.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkBj-0005R3-C2
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659AbZCTTN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZCTTN5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:13:57 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:47659 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZCTTN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 15:13:56 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1123134yxl.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=luLL+wYeWAjIL6BAPkIjtQJFzfFqP0FlWlwje9M+01I=;
        b=cIzgxURKofYq7D7X58vR8zjEqqyvwj/ukB/ftRKIrwtr9Fn4e/KQi114gWD5zMU/Ud
         g2IYyb8swpOdrBd4iqARcvMQfnOewAEo3EKON0K4yPsLGtg6Q6VR0MKnwk7S8RwIe1/n
         ZKqRZWLXQu+kq9162oy6oBRdAtGHjnysVHD1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Snh7DaPsW9W7MCq0pDHz25EfqRrzWWN+5EWylSxoZDjuLnVzLhFwVKe2jtLgPkYdj8
         55XqzdVlJxJNdHIP+hOv22n/NxecMgKR/9VnLVmeBAMO4bSuuRrM8C+5rLv1NS2cePcu
         VSfvzemcwzZ0Q/bC/MjLt5Owrty992//90b90=
Received: by 10.220.72.205 with SMTP id n13mr1982764vcj.115.1237576433535; 
	Fri, 20 Mar 2009 12:13:53 -0700 (PDT)
In-Reply-To: <20090320064813.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113991>

On Thu, Mar 19, 2009 at 5:48 PM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
>> I'd start like this:
>>
>> =A0 =A0 =A0 enum color_name {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_RESET,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_RED,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_GREEN,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_YELLOW,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_BLUE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_MAGENTA,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_CYAN,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 COLOR_WHITE
>> =A0 =A0 =A0 };
>
> Looking for "COLOR_RED" in the archive gives:
>
> =A0http://article.gmane.org/gmane.comp.version-control.git/109676
>

Duly noted.  Perhaps those #defines should be relocated to color.h?  If
we still wanted to provide a color_name type we could use
GIT_COLOR_NAME_RESET et al.  That would give us something like:

#define GIT_COLOR_NORMAL	""
#define GIT_COLOR_RESET		"\033[m"
#define GIT_COLOR_BOLD		"\033[1m"
#define GIT_COLOR_RED		"\033[31m"
#define GIT_COLOR_GREEN		"\033[32m"
#define GIT_COLOR_YELLOW	"\033[33m"
#define GIT_COLOR_BLUE		"\033[34m"
#define GIT_COLOR_CYAN		"\033[36m"
#define GIT_COLOR_BG_RED	"\033[41m"

enum color_name {
	GIT_COLOR_NAME_NORMAL
	GIT_COLOR_NAME_RESET,
	GIT_COLOR_NAME_RED,
	GIT_COLOR_NAME_GREEN,
	GIT_COLOR_NAME_YELLOW,
	GIT_COLOR_NAME_BLUE,
	GIT_COLOR_NAME_MAGENTA,
	GIT_COLOR_NAME_CYAN,
	GIT_COLOR_NAME_WHITE
	GIT_COLOR_NAME_BG_RED
};

/*
 * Map names to ANSI escape sequences.  Consider putting this in color.=
c
 * and providing color_name_get_ansi_code(enum color_name).
 */
const char* git_color_codes[] {
	GIT_COLOR_RESET,
	GIT_COLOR_BOLD,
	GIT_COLOR_RED,
	GIT_COLOR_GREEN,
	GIT_COLOR_YELLOW,
	GIT_COLOR_BLUE,
	GIT_COLOR_CYAN,
	GIT_COLOR_BG_RED,
};

That conveniently offers clients access to both the raw escape codes an=
d
a clear type for storing/handling colors.

~Allan
