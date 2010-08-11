From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 10:46:05 -0500
Message-ID: <4C62C5BD.3020808@mnsu.edu>
References: <4C5F9B25.8080401@st.com>
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	<4C624AE1.30504@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: mihai.dontu@gmail.com, Linus Walleij <linus.ml.walleij@gmail.com>,
	richardcochran@gmail.com, Felipe Contreras <felipe.contreras@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	"Gadiyar, Anand" <gadiyar@ti.com>, dwmw2@infradead.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Valeo de Vries <valeo@valeo.co.cc>
To: viresh kumar <viresh.kumar@st.com>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Wed Aug 11 17:46:51 2010
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from bombadil.infradead.org ([18.85.46.34])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1OjDVy-00074i-Lh
	for linux-arm-kernel@m.gmane.org; Wed, 11 Aug 2010 17:46:50 +0200
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjDVT-0006oX-Bh; Wed, 11 Aug 2010 15:46:19 +0000
Received: from mail.mnsu.edu ([134.29.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjDVO-0006mZ-QD; Wed, 11 Aug 2010 15:46:17 +0000
Received: from [134.29.32.1] (j3gum-3.ITS.MNSU.EDU [134.29.32.1])
	by mail.mnsu.edu (8.13.7/8.13.7) with ESMTP id o7BFk5eg025908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:46:06 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <4C624AE1.30504@st.com>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20100811_114614_982720_E8B2618C 
X-CRM114-Status: GOOD (  10.62  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on bombadil.infradead.org summary:
	Content analysis details:   (-0.0 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	-0.0 T_RP_MATCHES_RCVD Envelope sender domain matches handover relay
	domain
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153258>

On 08/11/2010 02:01 AM, viresh kumar wrote:
 > When i send a mail using git send-email then it receives fine on
 > outlook but on thunderbird, tabs are converted to spaces.
 >
 > This doesn't happen with every patch on thunderbird, but only a few.
 > And observation is that it happens only with big patches.
 > (more than 500 lines)
 >
 > Any idea, how to solve issue now on thunderbird??

Hello,

Exchange 2010 does not handle IMAP "chunking" (partial message transfer) 
correctly.  Any request after about 1 megabyte of total message size 
will fail.

Thunderbird uses this "chunking" feature to give you a status update 
while downloading large messages.  The IMAP statements are of this type:
11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)

When the 20480 is larger than 1MB Exchange "claims" there is no more.  
Sigh....

Fortunately you can disable this feature.  To disable this in 
Thunderbird you can go to the Advanced configuration and disable the 
following feature, by setting it to false:
mail.server.default.fetch_by_chunks


-- 
Jeffrey Hundstad
